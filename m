Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A112D2FDC36
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Nov 2025 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164954; cv=none; b=U6kyWvIB2DWVT0xT4QnKal2ebbeePM8Nv51jUbUkF3ZhPucqqN+IeQbwMhN/VDB7iRPKv3ZtisRRdKKlnJatjhBqZOv9PfQn3+YnnQgM3s64dp7zDpboRk7UQ5bSuYAEFwIOoEFukfh5106X9UQVutQfVwNoJPYjVt5kkt6s9IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164954; c=relaxed/simple;
	bh=1h+ElLyTAFUY2rDgK1kVX5WhcRuSSKcsxPxug7V7AiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2MQNUY+LPMhyZQIQX/HlV2dDb0SG6XDYFsDG5WCpKVcz/wOxGprU3ABqhQ2BLBsQX0YT5NOocg6yS/GzjL0Gw4/uHQA1lcvNbO8ZTM3ra5i1qc3gMXq+6ViBZGoQTv+GBW0OQIHTKm1yfH3CPyiVpk2V65UTfq/yE0vSBLlx3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FoxNWJmo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iFUp/uac; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FoxNWJmo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iFUp/uac"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762164949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrB/gSLdf3VA/om+dC5j8qNs8f2OaoR8P08bJ5Kp73k=;
	b=FoxNWJmo+ld5qzhUCv+HCRcQ0KtxHasJ/ErVn16eXHBfM/Pg/5eXNZvngUqXytkeOG75FB
	wwA6ikGs+SvND5a5kFbx9I0b9mG4/70iqJAOgg96hxZQUJgnpSP8kI9/roq5a3cuGa3/LG
	zyjbJLpZzjYPjs9Em0fgCbd7YOvSru/7mjQMV7ILcOYsBa9RsQEPRJyfaA3NuFUUMtBV2b
	qoC6EbVO0VKg023+sAaonXWHgME+RKw+OZsfdUKpfHaqS13o81HGKT5yirZ11fh/RRpF/o
	5iTQdsoMNjTWBqiw6NWhytPN6ugL0zLBzuIUyIkBgCN0ewC2FaTh7lhhzGsU8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762164949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrB/gSLdf3VA/om+dC5j8qNs8f2OaoR8P08bJ5Kp73k=;
	b=iFUp/uacy9LksbAsmAR66Id6bgYBzoc5hAYuGQmWXBakwocOjATfMXGekVe9Eiuo07ER0z
	tiQ0JpvpQwtuP6CA==
To: linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Cc: Russell King <linux@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 5/5] ARM: Allow to enable RT
Date: Mon,  3 Nov 2025 11:15:45 +0100
Message-ID: <20251103101545.760243-6-bigeasy@linutronix.de>
In-Reply-To: <20251103101545.760243-1-bigeasy@linutronix.de>
References: <20251103101545.760243-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All known issues have been adressed.
Allow to select RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 45d29320196f0..84ad4fe11589b 100644
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

