Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C458F5B;
	Mon, 26 Jan 2026 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769453150; cv=none; b=PkcvLx9GclVv/HCTPSgvgWd59qxGNBCfefOUmVGuL29/DVEkqmoW7oflXabmJgSyqzspM8V/1etTRbd6QWXRf+d0FEWsHF4QNOxRwalnVxdV97RU6g8a5MddI9PFDgC+1d0mOcwYCRMa/yskIQ/Wf4pskt3fj+ZajJI4au7zJqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769453150; c=relaxed/simple;
	bh=5dm2gNnlNKCEJ7IV/Esm7ZSSyEQUr8U45DCsA1QF7NQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JbA3fOcDiQ8kRDO/v2wpDSy5tVZ2AemFZLkOTbLkWf7VwA1lqZIsEdXgjfQ7GaiFszTT+BIDGpWuCDMTI9+bhSzFXy9/5+jAte6I/+FtPJb+OkCJBlxf3Qk3DteoKQvGSaHENhFqMeJsuuLFwzFEIUL9Mwl6syJmAt+anM+Y3q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbhjwAOB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbhjwAOB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71A3C116C6;
	Mon, 26 Jan 2026 18:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769453150;
	bh=5dm2gNnlNKCEJ7IV/Esm7ZSSyEQUr8U45DCsA1QF7NQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hbhjwAOB7KGADELZFk4CvosxFjVnBTAPLr4un/4IIW9uCxVNa8ccwPCLZJIBqcRgu
	 ps+pACPM9LrpSvckY2p6U2Dj6tRM0hA1u3d9mFAs6UgFXaBfVetNwWJkWvQlrtcFEJ
	 mOw29rlkhf7a4XezuY6G+dpuhOZxVuwzRg+movYnWbgwMkYdRL1K8W4aIfhq/r8fPd
	 4+GJRM+TsugRgqK60aUswwefWyVNsOIGvW+j8oWt9d9WqmOqzqIGklyN98P+q8NGkx
	 ET/5GRrTBNFmiE+cMjFkjFav5D29BHncQJoCek/j0lmv+btQ7FSxH0fZZHaaxqaLdC
	 K/tvqIgxWSpLA==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, Thomas Gleixner <tglx@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Amit Kucheria <amitk@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 David Lechner <dlechner@baylibre.com>, Dinh Nguyen <dinguyen@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Gustavo Silva <gustavograzs@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Kent Gustavsson <kent@minoris.se>, Lars-Peter Clausen <lars@metafoo.de>, 
 Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Linus Walleij <linusw@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Marcel Holtmann <marcel@holtmann.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Martin Tuma <martin.tuma@digiteqautomotive.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nishant Malpani <nish.malpani25@gmail.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Oder Chiou <oder_chiou@realtek.com>, Peter Huewe <peterhuewe@gmx.de>, 
 Puranjay Mohan <puranjay@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Ram Vegesna <ram.vegesna@broadcom.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Takashi Iwai <tiwai@suse.com>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Tony Luck <tony.luck@intel.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Will Deacon <will@kernel.org>, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Yiting Deng <yiting.deng@amlogic.com>, Yixun Lan <dlan@gentoo.org>, 
 Zhang Rui <rui.zhang@intel.com>
In-Reply-To: <20260123113708.416727-1-bigeasy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
Subject: Re: (subset) [PATCH 00/21] IRQF_ONESHOT clean up
Message-Id: <176945313962.769345.15364385456251549943.b4-ty@kernel.org>
Date: Mon, 26 Jan 2026 18:45:39 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Fri, 23 Jan 2026 12:36:46 +0100, Sebastian Andrzej Siewior wrote:
> There was a bug report about setting IRQF_ONESHOT where it should have
> not been set. I looked around for other mistakes in that area. There are
> the following categories:
> 
> - Using custom primary irq handler doing exactly what
>   irq_default_primary_handler() does
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[12/21] ASoC: codecs: rt56*: Remove IRQF_ONESHOT
        commit: 4a393958b6a1f8e476201437dbad2580d9b8700e

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

