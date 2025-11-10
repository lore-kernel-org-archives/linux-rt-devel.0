Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6886030C37A
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Nov 2025 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786586; cv=none; b=Knu9me0Yzx7AWdL7igi8taDjqSPG1XItq1tnF06RuhvkWySxm+kFVvuma7U1uK1xUVUkkd6ouy2Ko068QY0jUySYOqXS5kOZ+kAnkEGmuabxg35pjMvJ+cLHgyGccmDBIZjKY3Udy3IHDwDsjyCx3adcYgILc5jtWd+MMsEtm6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786586; c=relaxed/simple;
	bh=PILwUmsAVK9SzrqFIMgOW9WwagtI+lAZwK0xRgWZPLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLxY2LnvHGPO9zoQEvQNcE57OuG06n5A9eH+Pq9UfHDyUa4ANa/d7ur38/Sk2NZsE6oW7zbJAUbO0LhU/EJ5wWK/9pVQdGo5ZH3eElUCup8I3vIvMgHad40D1icuZdV1RhJeLuwif23J1ph7zecR2JL8+iDArQiaGxJip5kYhNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1tVwv80Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5WVnCrtp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1tVwv80Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5WVnCrtp"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762786581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PJymOvZBuj9Xya76U38SF3/ORWqJCuOIk9n/b6JWvU=;
	b=1tVwv80QQi6EuIjS6GrOFcp0ICq5yEvoHW5iS/HGmdgHUIBBXTKyw+k71dxHbyFpvjBsnQ
	j6iMNgmS5vaVgLO5CScppZMNU3Wm9sOO6BJriOZAowGOS3niPHfwoEC+SrOEUo1RY8R+Wj
	aaX33Bn/vobuXq9PVIctKKUwyUuYQ9MAhqSY5MD/jAON8ZZPIK+cjaDeSBBzik3DOj4zk+
	Z2dcwWhoFBoFKnww8U5gVqtzFshuwlr0/iUJ7+VsVud+/heAGP11VlUvfRORa+yHaNbLMB
	iIOJncgs/Ru+RtNzIS26PwAyMwGzmJpipiTHJjkdM9dWrTMPAVz/bPH1tJr3hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762786581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PJymOvZBuj9Xya76U38SF3/ORWqJCuOIk9n/b6JWvU=;
	b=5WVnCrtprX20wbzTV+Dl6NI9gtHrTqP3EKMfMjLVOt9e6OMuVQha0kHlVY2b4Xh4mpryQ+
	T/Q/KpTPn1nV1fBA==
To: linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Cc: Russell King <linux@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 5/5] ARM: Allow to enable RT
Date: Mon, 10 Nov 2025 15:55:55 +0100
Message-ID: <20251110145555.2555055-6-bigeasy@linutronix.de>
In-Reply-To: <20251110145555.2555055-1-bigeasy@linutronix.de>
References: <20251110145555.2555055-1-bigeasy@linutronix.de>
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
index 822d378f81ec8..b32f85f14c28a 100644
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

