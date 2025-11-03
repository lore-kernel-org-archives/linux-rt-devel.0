Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFFA2FD66F
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Nov 2025 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164953; cv=none; b=bLJ5BE5P9EWiij5C4CbV72vnTxzQf3Ru2aNl1HYI1IjhpHUJMB1hzVT211giA3PvHAs7zYYu9sUYkuhvgen7M/1FYbAiVOT89/a0SUBxldOf3rN1KVw2tE2t7PsjPZFZzDbysc2KG1Dql1xPe64rsSFmICWxW8fGyRSV8ioAguE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164953; c=relaxed/simple;
	bh=PRY7Lck05eceIVgciJsvkALtjC+ne22v2N2Dx7cNIdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuYqL+a6PpnN8FPu2v3rHNsWDl7ujIDDr6Iw5S0CGeErXoN0vCA7jG/4EBPR6YnA20R3itq0VB4dSCxYbEz9h32eGEwr8Ay8PEx1CBRJtE0wbV5E7xOhPmJtYkk78Yj7sKI5/WNJ8nDZaNGpTWi3mY+XwFQflCnl1Yh31nInrf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ceFmENrl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vD8id2aR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ceFmENrl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vD8id2aR"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762164948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KaU7p8ahmNCHaG3kbOaKByvc4PL/i8FOp86ZUuzimbc=;
	b=ceFmENrl4NDS42u8BwvnJbx5VpAEI2Rfo1PEn4iLZUAPYMtq6rRH1Ojd+2LnDfBkN4Up6T
	pIuycKv8DHZTmUKa4H9W+7WnYrxhs4yND6Y+JwLKbUfgHrVO14WtS7btFh6pkPwU6Ae6E6
	v17WBWFJ0Ix4fH5Eu1GuCYJjMbVv2AcrJIxWZZR+te8QIcp/TMq7meadtIJtJT/by60HEN
	at+Eq+UFbNpGwqf+ypqni//O7v3G4nX1VDy/+9W5RJ7o9DD592YEkF36tTqvCdI/gRVuv/
	TD3aKBB4O59IoqFPvnjxSaidBoC7QyOozG49DnyLIlMed0K1f4Z5QSK5FbLhAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762164948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KaU7p8ahmNCHaG3kbOaKByvc4PL/i8FOp86ZUuzimbc=;
	b=vD8id2aR4V8Qnneq8LT5WWROYZKpgDA74fFqZZ+o1i+A7J4h4M5noHNhM5WpfxAJPmH8C8
	/ocqUkOzjahjGnCQ==
To: linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Cc: Russell King <linux@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Yadi.hu" <yadi.hu@windriver.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 2/5] ARM: mm: fault: Enable interrupts before invoking __do_user_fault()
Date: Mon,  3 Nov 2025 11:15:42 +0100
Message-ID: <20251103101545.760243-3-bigeasy@linutronix.de>
In-Reply-To: <20251103101545.760243-1-bigeasy@linutronix.de>
References: <20251103101545.760243-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Yadi.hu" <yadi.hu@windriver.com>

In the !LPAE case __do_user_fault() is invoked from do_bad_area(). If a
user pointer cause the page fault then a signal is sent.

Sending a signal requires to acquire sighand_struct::siglock which is a
spinlock_t. On PREEMPT_RT spinlock_t becomes a sleeping spin lock which
requires interrupts to be enabled. Since the calling context is user
land, interrupts must have been enabled so it is fine to enable them in
this case.

Enable interrupts in do_bad_area() before invoking __do_user_fault().

[bigeasy: Initial patch/ report by Yadi. Maintained the patch and redid
          the patch description since]

Signed-off-by: Yadi.hu <yadi.hu@windriver.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mm/fault.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 5d28c28e877c1..ad58c1e22a5f9 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -218,6 +218,7 @@ void do_bad_area(unsigned long addr, unsigned int fsr, =
struct pt_regs *regs)
 	if (user_mode(regs)) {
 		if (addr >=3D TASK_SIZE)
 			harden_branch_predictor();
+		local_irq_enable();
 		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
 	} else {
 		__do_kernel_fault(mm, addr, fsr, regs);
--=20
2.51.0

