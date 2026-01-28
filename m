Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68A9270ED7;
	Wed, 28 Jan 2026 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616802; cv=none; b=FT3mvRxKzlyeD9p8V9TXzHpmc5uJAPreITgMyY2XFWu7IZbtDunpbGchVVazLmDTQnsuZw15YM2kZIMXqVedG581r43nWy6Ll/JISYivIOa+zfpC/1a0E+5TVtEXTdfb0nF9ws6WPK1dfysEytYkwA01aO2v0bOyMNQmxong+F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616802; c=relaxed/simple;
	bh=eKsOfls89oC7TYzxBqHKWCc9CS/ykrs7Pu5eJTYZazw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbML/knQbTtPhxRQX0hJlCBoWoSZLhgLQAxW7a7mSw1953Z5IlTL8G9YIVvUUXnlyc/bVzlbBsYtMyYRF1whC2Z5pMqJSRNf5PkRGzye50dMO4UO3N8lPBrLxyPSRKQ+GRaPO1XDJPVMZLF0fz2hodl7NUmjE8U4lUwhGKzeT1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4AIDmjw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4AIDmjw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADBFC4CEF1;
	Wed, 28 Jan 2026 16:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769616802;
	bh=eKsOfls89oC7TYzxBqHKWCc9CS/ykrs7Pu5eJTYZazw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s4AIDmjwBTInkFgOGmb7TFbYCMnvIOg9CDVHEc7YkXfmN1HrQjIpVn0cjubGkhwgs
	 JcuKj8vf5UufyeTPLejJFyOinlAC23rvcCyalhqnecsPywweHhxxvJXSP9YUqtyWbZ
	 apW6Gr3jiUsEQPROPWJP46k5nStEVPdNIDWlgWb4PAAX2r2+NTKXUuuE32CLSq/eNh
	 NwhXI/SvZI7+pPtQbACg6Almu9+6QJ+VP8AGM0Q/TCeaUXkR+peVRT6OqJKJDlveYT
	 /zuw53qjIweZwsSbKrwrzY6t3/Wrg4nzIevgwKQpBzWXspp6wpu4Y1W/BRAB5vrvXE
	 01SIUIyCWfXrQ==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Amit Kucheria <amitk@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	David Lechner <dlechner@baylibre.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Kent Gustavsson <kent@minoris.se>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Puranjay Mohan <puranjay@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ram Vegesna <ram.vegesna@broadcom.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Takashi Iwai <tiwai@suse.com>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Tony Luck <tony.luck@intel.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Yiting Deng <yiting.deng@amlogic.com>,
	Yixun Lan <dlan@gentoo.org>,
	Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2 00/20] IRQF_ONESHOT clean up
Date: Wed, 28 Jan 2026 16:12:58 +0000
Message-ID: <176960556542.3584449.13472244828360969713.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128095540.863589-1-bigeasy@linutronix.de>
References: <20260128095540.863589-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 28 Jan 2026 10:55:20 +0100, Sebastian Andrzej Siewior wrote:
> There was a bug report about setting IRQF_ONESHOT where it should have
> not been set. I looked around for other mistakes in that area. There are
> the following categories:
> 
> - Using custom primary irq handler doing exactly what
>   irq_default_primary_handler() does
> 
> [...]

Applied the CXL PMU patch to will (for-next/perf), thanks!

[14/20] perf/cxlpmu: Replace IRQF_ONESHOT with IRQF_NO_THREAD
        https://git.kernel.org/will/c/ab26d9c85554

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
