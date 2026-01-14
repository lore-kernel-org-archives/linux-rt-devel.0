Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B927D36C5A1;
	Wed, 14 Jan 2026 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426616; cv=none; b=gY6k97fCxpsd9NdSBJFboKUCn2/G3mF4Rb5tiPbTZY9LVBTOG+ZF9tDuQy1gDr20nsZx0d/7UlguyT7mshFLCfubisTV00LdLvPaHw86QBwYc7jH1oKSmtoatDFma3nJJS4/JcqZz+dVwUSoXtmP/oNuwixsNSih325x9Oft3Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426616; c=relaxed/simple;
	bh=L/ajtLTp+UwmxkvNxgpr4k0d3uNJwnctABro5LBQATs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OfnmASZ5Jf9fMA65Pc8hC7e4um+ZHPebYUrVLoQ5DkHpIXM0JNplVzF8dBWzosqOu9f731MDEUJ3OwGvD3SPZzdKXBgPVD6YeGWsCcu35UW9CSww4jB/XOZU3iDwWaK1jWVtp1a5WgPb62JUrUCTH3QyiKjezhO28ZBw9Gcjy8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbhiY9Np; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbhiY9Np"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30278C4CEF7;
	Wed, 14 Jan 2026 21:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768426615;
	bh=L/ajtLTp+UwmxkvNxgpr4k0d3uNJwnctABro5LBQATs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KbhiY9Npe3rsRRElnpp52TeMGpd6DQmKNy02KV1RIIFQ2Pz5GTIEPcx1uU6SlBx3X
	 il59qx3FEGk0oQW1sUumeBt2BF7pGPvghifcDKIli6BGOOl1j8BDh+vig6Js7V4bup
	 CuE5TjjfbAJv/sxonm4LO1AzaF7ka/9J0WdmbX+X5fTHCss0OjTItVxrAFpMgRhbaD
	 ux32zCDRXhC6AS87JtMMoq8UYk/J89WX+QYNGEjV4ko5WBnL5RK32ddB5kvcBf6Gwq
	 HOuMY1ddJFkkHGHhmjEHl9cMhj3Ep5IqJ2dQvYer+w7jsf++eO0Ljm/TCCDzecjNO0
	 GPDEPXtSMVpBw==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Dan Murphy <dmurphy@ti.com>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kevin Lu <luminlong@139.com>, linux-rt-devel@lists.linux.dev, 
 devicetree@vger.kernel.org, Emil Svendsen <emas@bang-olufsen.dk>, 
 Dimitrios Katsaros <patcherwork@gmail.com>, 
 Emil-Juhl <juhl.emildahl@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260113-sound-soc-codecs-tvl320adcx140-v4-0-8f7ecec525c8@pengutronix.de>
References: <20260113-sound-soc-codecs-tvl320adcx140-v4-0-8f7ecec525c8@pengutronix.de>
Subject: Re: [PATCH v4 00/10] sound: codecs: tlv320adcx140: assorted
 patches
Message-Id: <176842661093.229619.8670109372292591040.b4-ty@kernel.org>
Date: Wed, 14 Jan 2026 21:36:50 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Tue, 13 Jan 2026 11:58:43 +0100, Sascha Hauer wrote:
> These are some patches for the tlv320adcx140 codec we are carrying
> around for a while, time to upstream them.
> 
> First four patches are fixes. The following four add regulator support
> for AVDD and IOVDD. The remaining three patches add more controls to the
> driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/10] ASoC: tlv320adcx140: invert DRE_ENABLE
        commit: 4130dc47ce8f60d289d91e2bdd18c4d863ca3237
[02/10] ASoC: tlv320adcx140: fix null pointer
        commit: be7664c81d3129fc313ef62ff275fd3d33cfecd4
[03/10] ASoC: tlv320adcx140: Propagate error codes during probe
        commit: d89aad92cfd15edbd704746f44c98fe687f9366f
[04/10] ASoC: tlv320adcx140: fix word length
        commit: 46378ab9fcb796dca46b51e10646f636e2c661f9
[05/10] ASoC: tlv320adcx140: power on/off the device on demand
        commit: 24175015263d3c72166902a5a4451c18dc836d56
[06/10] ASoC: tlv320adcx140: add avdd and iovdd supply
        commit: 57be1f67401005e33e8c88db6707b4482b509589
[07/10] ASoC: dt-bindings: clarify areg-supply documentation
        commit: 5682093fc80674ee7f4a96dd9f0f1919111ab16d
[08/10] ASoC: dt-bindings: add avdd and iovdd supply
        commit: 4a1bc07e6d9ecd29b95c41e34402793619f1874a
[09/10] ASoC: tlv320adcx140: add kcontrol for num biquads
        commit: 2219823f7d6ac01c8eb55b90e954b4466146c397
[10/10] ASoC: tlv320adcx140: add channel sum control
        commit: 8a98e7f55f975360975083166e21982ef307b8fd

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

