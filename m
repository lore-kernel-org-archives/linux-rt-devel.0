Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091841;
	b=oAzv7LWr9Y1dYfOMrYPtTu2N5QA1YBOkMgKLukaqgpwqLe6hGVkAmryEYQRGyS1+m95t
	 wedIaJrwPj0k2GhxSER01Bzu10LDLe6gBK1D17NCTz1opRNvDYEob/lTTMZGP0EPy+wjK
	 7oUeUkbfk/TXbqnwAT7huocElmI6e1Nos1oB00alHsapWzwrIF51HQds/Ktb2d5sWeQSO
	 dhNsZpE3FHY+hWZhlcJ9CX3IswPXvSeqDqsgk1bMQXmkSyYs2L2ZxcBiwgN2hk8OXDpTo
	 Be8zflHhaUXaWfu6FNrkcAKDbUNtkYdSyNLt0dLVFSDylH2BfXb0R5ADhKYhYeTCFRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091841;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=3t5GjNWjLeDJ7jf+sWjWE+z8pgne1HFP6Z9ewGr3ciM=;
	b=M8CtpkkefS8naGjk97Ys8FUpgUa7XIpgUvqQKKk8lzrAxxRtPQJ+7+9SXl0o7Ar9g9br
	 JamzeMenCICAREEtlUb1MwsJC8OnO4KwEZT6umSD6zYO/uAPA788XX8OxZZVTsLrTHK6M
	 3W03wKF/dYIsHT6jFOzbgTyIAA1tIoSC7xJxke5aq12BWmRjsjxinarqlsHt4srJrPjJi
	 je2uzyQzWFa1zZWRqXprosUPS3zxkzw0EsrBmLIf3gbhYjzgvLG/2U/EKtUNHXMgtUwTY
	 VLz4KVK8QXt88GaxvU4qq2uLtiGZrlLfm5JSCzEBhB0xnCeYRYyNg5gVCC5dC2nTyXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=zPTod43m;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28305606A320;
	Thu, 19 Nov 2026 12:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28305606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=zPTod43m
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1D257C4CBEF;
	Thu, 19 Nov 2026 12:37:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D364760237;
	Thu, 19 Nov 2026 12:37:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 510D011BC0760;
	Thu, 19 Nov 2026 13:37:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795091838; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3t5GjNWjLeDJ7jf+sWjWE+z8pgne1HFP6Z9ewGr3ciM=;
	b=zPTod43mAzLSSRgzVXjEmLAXkDGnxePwHhzkScC5gOoZIjGIKZrN9qQvXbbt1f7+xrC40e
	kWUCCNvwwMyXfEALuAkbI6u43LkZV+KGC2c/ZOzEC/4phQiCmL+YZvS/0THt2ekxxWgacR
	tu7CMv3of0F6uZOdw6R8k2L12mJN5gyaXmuGe1K6spBswNWI3ATX0X/XQ7ZA2z7l13ESfg
	kwKykGxuin8gKfntIgliW+nEo2ixhWg5Bzv5yitkMs863ypkm2GLvGpNgpDzkCG0uUn5xX
	pbht3yp6JD1MYGDKDfPS30lAM6tMEFTzS0HNicPVhEZ+CUIh0fnUDT+oK4PxKg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 devicetree@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-0-dca1f6ed29a8@gmail.com>
References: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-0-dca1f6ed29a8@gmail.com>
Subject: Re: [PATCH v10 00/26] mtd: rawnand: sunxi: fix transfers and
 support randomized OOB
Message-Id: <179509183211.2889394.16825117934214735151.b4-ty@bootlin.com>
Date: Thu, 19 Nov 2026 13:37:12 +0100
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 05 Nov 2026 11:55:16 -0700, James Hilliard wrote:
> Patches 1-24 address the existing driver independently of the Allwinner
> randomized-OOB format in patches 25-26. Please review and apply that prefix
> regardless of whether the format extension is accepted. Supported geometries
> keep their existing on-flash ECC layout, bad-block-marker representation
> and raw callbacks.
> 
> Patches 1-3 prepare the shared paths: centralize OOB handling, share the
> NORMAL-command chunk-size calculation, and remove duplicate chip setup
> immediately before core page commands. The DMA writer retains its early
> setup because it accesses controller registers before program-begin.
> 
> [...]

Applied to nand/next, thanks!

[01/26] mtd: rawnand: sunxi: centralize OOB handling
        (no commit info)
[02/26] mtd: rawnand: sunxi: share the buffer transfer chunk size
        commit: 53013c67871f3f31b0181ffed8a14ba6b9466427
[03/26] mtd: rawnand: sunxi: avoid duplicate chip setup before page commands
        commit: 2bd4acab1e0e16c06ac64f60aa01a72d0e651616
[04/26] mtd: rawnand: sunxi: reject pages exceeding the ECC step limit
        commit: 5eb28d68d67a22f5b2f9d98d9567b01f432bb88d
[05/26] mtd: rawnand: sunxi: use the logical step's OOB length in PIO
        (no commit info)
[06/26] mtd: rawnand: sunxi: propagate page-setup and erased-check errors
        (no commit info)
[07/26] mtd: rawnand: sunxi: drain interrupts before reusing the completion
        (no commit info)
[08/26] mtd: rawnand: sunxi: stop failed program operations and disable ECC
        (no commit info)
[09/26] mtd: rawnand: sunxi: select the pattern ID for the current ECC step
        (no commit info)
[10/26] mtd: rawnand: sunxi: preserve synthesized zero-pattern data and OOB
        (no commit info)
[11/26] mtd: rawnand: sunxi: propagate buffer and column transfer errors
        (no commit info)
[12/26] mtd: rawnand: sunxi: avoid a second program confirm for OOB writes
        (no commit info)
[13/26] mtd: rawnand: sunxi: use page reads to reposition small-page NAND
        (no commit info)
[14/26] mtd: rawnand: sunxi: bound DMA batches by the user-data register bank
        (no commit info)
[15/26] mtd: rawnand: sunxi: send all address cycles in split operations
        (no commit info)
[16/26] mtd: rawnand: sunxi: propagate chip clock setup errors
        (no commit info)
[17/26] mtd: rawnand: sunxi: limit buffer transfers to the command byte count
        (no commit info)
[18/26] mtd: rawnand: sunxi: skip unavailable NAND child nodes
        (no commit info)
[19/26] mtd: rawnand: sunxi: scan all chips before registering MTD devices
        (no commit info)
[20/26] dt-bindings: mtd: sunxi: require the H616 AHB reset
        (no commit info)
[21/26] mtd: rawnand: sunxi: reset the H616 data path after DMA aborts
        (no commit info)
[22/26] mtd: rawnand: sunxi: reuse ECC status within each transfer
        (no commit info)
[23/26] mtd: rawnand: sunxi: avoid redundant column changes for extra OOB
        (no commit info)
[24/26] mtd: rawnand: sunxi: reduce user-data length register accesses
        (no commit info)
[25/26] dt-bindings: mtd: sunxi: Add randomized OOB flag
        (no commit info)
[26/26] mtd: rawnand: sunxi: support the Allwinner randomized OOB format
        (no commit info)

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

