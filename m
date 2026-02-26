Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B84A366553
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Feb 2026 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772104676; cv=none; b=PS7MplMDnEen9OuqF0tWWoJv95uu1drD63ClNn4W7vcExQ8n7hQFcZEim8m2KQbyfhiLhRQRCvTYSWPTxzrQix4SLYH3j1bjlfkGST7ktNspVLpXJZuu+ytY7dH+5zM/b+YYXWssqrnTDI4myCLreiQrQU8Cxpch1gwkfVQB90o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772104676; c=relaxed/simple;
	bh=af+PGdg6quOgxcfBD0yVJa9iiNO0aL8pC4oJPLijKkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqqXcWXREEi2UEEurF82SPATaCtNndHYaKv5MT4SXewxKuHwdnN0yXPppJLj/f6TodKv8HwLHtbmoHO6qgpE3IxT72eHU3e/vnRyedOs31AQ24r0zqEReFvnRjjicCQIuwwYsUXY4PfKjLoWyCwtMMb4V1AXLkJGiIRUVCcrXiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NH8KbA/v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SMKMJR9R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NH8KbA/v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SMKMJR9R"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772104672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LEGKQUY3P/ldkHZI7vdWyqz71XJp0++m8PAVddsvFcM=;
	b=NH8KbA/vpUBsiB7XbEhJehmDnS4Pef6bahDF+mgIbeH0Qkm1dFuK69BPMz9BfiYFrKVSfL
	gbsI0zLOsnASijXSM8eW4mqQxH+bLuOlBa0BBxfFMG04UbrbtgiyS+9LC5cxAlyRm7pjGi
	TzJtRRpf1QiTeCj6sE8a6bqnH+q1iylWVJUzPoQI4sCDUrHxaYlr5p/uE4RSeUNXzHbcNh
	dxHTRnt5JymGmzJc03TS39rpB9rUVNZfvj845SabEovxs+q6+SuZBYDhpCKO4yX0nxBBnL
	JZr0ilZqv/RngoU/q16ClfKRWCVSRycQztyyRL9c7ItUw5mFb9oajJjQKQxBTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772104672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LEGKQUY3P/ldkHZI7vdWyqz71XJp0++m8PAVddsvFcM=;
	b=SMKMJR9RYhrFqHjNliI9wvA0kMYVeyaPgOai9PUF13+UwjI1Kkjo3xQUpnvLM/n+Zt1kYo
	Xht0SBxgdJeD7RBg==
To: linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Cc: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v5 2/2] ARM: Allow to enable RT
Date: Thu, 26 Feb 2026 12:17:42 +0100
Message-ID: <20260226111742.3598421-3-bigeasy@linutronix.de>
In-Reply-To: <20260226111742.3598421-1-bigeasy@linutronix.de>
References: <20260226111742.3598421-1-bigeasy@linutronix.de>
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
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ec33376f8e2ba..71fc5dd4123f3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -42,6 +42,7 @@ config ARM
 	select ARCH_SUPPORTS_CFI
 	select ARCH_SUPPORTS_HUGETLBFS if ARM_LPAE
 	select ARCH_SUPPORTS_PER_VMA_LOCK
+	select ARCH_SUPPORTS_RT
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_MEMTEST
--=20
2.51.0

