import os
import tempfile
from abc import ABC, abstractmethod
from typing import Iterator, Callable

from modules.sela.definitions import Filename, URL
from modules.sela.exceptions import UnsuccessfulRequest
from modules.sela.providers.abstract import Provider
from modules.sela.stages.logger import Logger
from modules.sela.status import HTTPStatus


class Downloader(ABC):
    """
    Responsible for downloading a release.
    """

    @abstractmethod
    def download(self, downloadables: dict[Filename, URL]) -> list[Filename]:
        raise NotImplementedError


class DefaultDownloader(Downloader):
    """
    Default class that will, by default, download the dict of files using the provider
    and return the path towards the downloaded elements.
    """

    KILOBYTES_DENOMINATOR = 1_000

    def __init__(self,
                 logger: Logger,
                 provider: Provider,
                 download_dir: Filename = tempfile.gettempdir()):
        self.logger = logger
        self.provider = provider
        self.download_dir = download_dir

    def download(self, downloadables: dict[Filename, URL]) -> list[Filename]:
        files = []
        self.logger.log_progress("Starting downloads...")
        for fn, url in downloadables.items():
            fn_abs = os.path.join(self.download_dir, fn)
            files.append(fn_abs)

            self.logger.log_progress(f"Downloading {fn}")

            with open(fn_abs, "wb") as out:
                for status, bread, btotal, data in self.provider.download(url):
                    self.check_status(url, status)

                    self.logger.log_progress_bar(
                        f"\r{round(bread / DefaultDownloader.KILOBYTES_DENOMINATOR)}"
                        f"/{round(btotal / DefaultDownloader.KILOBYTES_DENOMINATOR)} KB "
                        f"| {round((bread / btotal) * 100, 1)}% | {fn}"
                    )

                    out.write(data)
                self.logger.log_progress_bar("\n")

        return files

    def check_status(self, url, status: HTTPStatus):
        """
        :raises UnsuccessfulRequest: on unsuccesful status
        """
        if not status.is_successful():
            raise UnsuccessfulRequest(f"Couldn't download asset at url {url}", status)