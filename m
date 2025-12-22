Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3433587D9
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Dec 2025 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442919; cv=none; b=oZmPb8cGhhb7d4Pxsne+Hv97anH1MCM77Ko9s5Cc37lWNSTR6b8Eji9WhE6T1s9X6GIq6jJDVgH+edCdBQ+dzureMYf/z+Z/4kxhEqCJzIdnwv3JDpzFvoPqHFmouqAkkQVd4t2SBA2wVnqfjFGUu7TgwhiS+YU3n6fQYaFktrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442919; c=relaxed/simple;
	bh=GSKsp1tL5XWySG9N8gPclLRwT1ctjdcM0v5lU06dUaI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JETZ2m8eKR5ARBumCTgYXeIiu3F1+Vpdg6WCAnnayC3NUNHP5M7/nbA96wUNaGQpLNj+p+WWHtkRVjUPbJ1oSPMYNYhtXdUdESr/7GoFPD+FmmLLtY/VbiA9T7L9GRxNs/o58R1HpIsm7Uw9vg9BhRSXQLDT2hQj0mXYw5L0YRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=XNUz8oPX; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="XNUz8oPX"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E004C4040B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1766442915; bh=TUEuW0fHa6kMfeithA5xJodq6Ikm0TL8c0pT5q/8Q50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XNUz8oPXKygV64KpxvjI2rOiUr1HrQm1qsn28edY/HVNTO9bnXPyBjKzPHvDkIDnH
	 MngCOgbGWnhKTtNvlc10bTyZe5tU6CZSto0IcZbEej6atAF/liL3Q7g2Cgs2RUGN0I
	 XuBeG3EEdqzHamA2Z/93OrklFoR3DY0kyqAYjW179sXUT4wP8ECma2u0f8J0x0gchZ
	 53cAJXqbspHpawAdo3y6MhbkIOAP30A2hBi28ZLxp/eOICK82K1VfuYiH3+Y4TiLFl
	 B80JFE7DPeKf0hBebroNUGewgMFKjZU4EpW7909rwUBnSsan1ol/4WzECg7Bf2heLj
	 64TG0HFsw3nZQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E004C4040B;
	Mon, 22 Dec 2025 22:35:14 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: Clark Williams <clrkwllms@kernel.org>, John Ogness
 <john.ogness@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 0/3] Documentation: Update the real-time documentation
In-Reply-To: <20251127154343.292156-1-bigeasy@linutronix.de>
References: <20251127154343.292156-1-bigeasy@linutronix.de>
Date: Mon, 22 Dec 2025 15:35:14 -0700
Message-ID: <87zf7axhzx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> This series adds an overview over hardware. It does not explain every
> tiny bit but explains for instance why power management or USB might be
> a bad thing.
>
> I also collected Lukas' patches which rename a referenced Kconfig symbol
> and a maintainers entry for the docs.
>
> v1=E2=80=A6v2: https://lore.kernel.org/all/20251120113708.83671-1-bigeasy=
@linutronix.de/
> - picked up tags
> - s/busses/buses/ as per Randy Dunlap
>
> Lukas Bulwahn (2):
>   Documentation: update config name in real-time architecture support
>   MAINTAINERS: Add doc files on real-time support to Real-time Linux
>
> Sebastian Andrzej Siewior (1):
>   Documentation: Add some hardware hints for real-time
>
>  .../real-time/architecture-porting.rst        |   3 +-
>  Documentation/core-api/real-time/hardware.rst | 132 ++++++++++++++++++
>  Documentation/core-api/real-time/index.rst    |   1 +
>  MAINTAINERS                                   |   1 +
>  4 files changed, 136 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/core-api/real-time/hardware.rst

Set applied, thanks.

jon
