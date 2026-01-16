Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6569D347BA7
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582854; cv=none; b=r8iL2CfDLgMo5kbU4/bOPfGqknV+LD3a2JZC6mTgQF0nDly6f9I9Ubv9v6aBWE+/Pv2rmVWZr9vDhAZJ03Lfyyvq8pg1D/vVba3xSkI0YlupM9EF36x69ts3c/eL1mQw7KgR/Pyvf7F1wKNRlqeb0mB/jSBHlVQDMTT6i1dfoWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582854; c=relaxed/simple;
	bh=Aqb26ZQvpWTl+gDVHyzgMZxRLSl2mHlpeFTJQAXzxCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jngWZG4ZxOLLEkHc4Urwt1rPh0j7jly/cD4gcRGUooAg3VZPq7zeoW7F++wwoRqi7eSI/ju5K7ARhKg8pa9KGTgzQ4sVp5D6NigQ/41wj0HzBnQ704Ul9n6xS39aoLxUERsgJMWbYkUeKALRpugf42WRA5HztEgRouV1pPJ9Cew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hRxuxlBe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CdjdnzXV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hRxuxlBe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CdjdnzXV"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768582851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ky8EGhAbwDxSiGd+vPASPYnyZb+Sx+A2spx1YzJQeR4=;
	b=hRxuxlBeyiIv+XUncVep0DQoBQgJcoCYAUaECGBxUcUKtBlCi42ej+Z9Heu9HtF7AzZxDc
	2eJ3YGyZjvpnGYITLt2FXvvP1DPVTrNQqbrPFrQrfIVq9vWp88/14KWhi+njibykQMa85Q
	8vuHq2TtoMWIzzF1R2UpRjkdedxEUVhvzOZL8cm9Wh2Fu7XjwkdHk7qo6MHBqwTUIQY2Oj
	g2lX0SrgJ0eIcrt4GK0Ktro2zs+k1TqZyj2U4IZjIy5uebZ9ZkMESiipNWFz1N7qlpJtwa
	JwOzkA8ZyWCxFG7mPEkGh6ZtCSDjo5aJIeshci0AUY1DZVaSD5BFXe3eip/n4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768582851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ky8EGhAbwDxSiGd+vPASPYnyZb+Sx+A2spx1YzJQeR4=;
	b=CdjdnzXV3vWcZr5Jif5md1pvNn7rA9CQEnxPsdXygk2X3PeRj/aI3CdMqs0QETl1Lb0iEe
	LGSgaZAxKaNcPyCA==
To: linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Cc: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Bryan Brattlof <bb@ti.com>
Subject: [PATCH v4 2/2] ARM: Allow to enable RT
Date: Fri, 16 Jan 2026 18:00:41 +0100
Message-ID: <20260116170041.1059997-3-bigeasy@linutronix.de>
In-Reply-To: <20260116170041.1059997-1-bigeasy@linutronix.de>
References: <20260116170041.1059997-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All known issues have been adressed.
Allow to select RT.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fa83c040ee2d4..547df4161e0dd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -41,6 +41,7 @@ config ARM
 	select ARCH_SUPPORTS_CFI
 	select ARCH_SUPPORTS_HUGETLBFS if ARM_LPAE
 	select ARCH_SUPPORTS_PER_VMA_LOCK
+	select ARCH_SUPPORTS_RT
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_MEMTEST
--=20
2.51.0

