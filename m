Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535ED2FD1B1
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Nov 2025 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164951; cv=none; b=l+h2RKTZP8mmAugSupjaC22ejGzh6GE6pmJyHHaNWAvl8r6zU2SKwjUANwPS8V+XI8OFgbNfCCl9vYSn91lWUlAyoJouN+28DLa30inEuL+GhCOhfeq8RrLPR1koIiN890HjOu1+auiGnunLgeqZISl7pBMn1+uuW/YRTXUKYGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164951; c=relaxed/simple;
	bh=T4neA2uMcCAzR3clZU0g+26aZMdkI3wnLZ7i+f6KJbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SpjyL9BbhpeXPSA7zUCVfqeJQ58iYbP6EqpPQ5OxJB2dTOkwAqr6Y2VlgyDPaii93oDF76V1kXiH/yOJQ0ACyV30dSTc1vsd+4IPsmXVRENIir7t+jA+jM+x8e1m/Ff+fVSok15/PMv+BbqmcMzP374ksFD1XMPDhoQ7UB1xwPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lktdhd8O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=22tKgmVT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lktdhd8O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="22tKgmVT"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762164947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tS0MhUe7KY1JxyB8FA5hPJlAGmWi888eRvQYge3RUY0=;
	b=Lktdhd8Ogqpeh2d00Mj+SWegbA0xdE0cfDr+m25Q0+W/aAuq+IUiY1yQcQPFp/Fz2ySg3f
	2SJRhUBWE/C/ghEHkwaKL5M89DWv2J61e3yu4iT+nuhU9bw/ZYYePIqNv/j1YPV5F/ETTr
	VZm8vBhyfSkTwo77BPNlK6daYcpUnnQTRHTSKpWSJX+mq/2cMYa9VHxtjvdBNNe/HI82Q2
	EaYYv+4jdcFrqpwqm0Hb7J9TEe93/v5nFP4nz5L+hdjLYEGNoRc5V9DcS3qrfATHtl8nnx
	M0s+QvdqVIxCP6lBCgGHuok7uks9ARoFLfvKsKG1E/TCE6S6tPwWA0bFmqgpkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762164947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tS0MhUe7KY1JxyB8FA5hPJlAGmWi888eRvQYge3RUY0=;
	b=22tKgmVTCnMRRdsnLTJmuJkSqEuvGcL6DUOl2QpHhdeWDtupClhiy6NDcuEUAJXI+dOY2v
	POdYR1saXF5MRTBw==
To: linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Cc: Russell King <linux@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 0/5] ARM: Remaining PREEMPT_RT bits
Date: Mon,  3 Nov 2025 11:15:40 +0100
Message-ID: <20251103101545.760243-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

this is the last batch I have to enable PREEMPT_RT on the ARM
architecture.
Last time I posted them there was some discussion about making the
branch predictor hardening worse. I redid it hoping it improved now and
does not make it worse.

v1=E2=80=A6v2: https://lore.kernel.org/all/20251029155918.503060-1-bigeasy@=
linutronix.de
  - Allow to enable jump-labels on UP. The UP build does not involve
    stop_machine(). Reworked by Arnd.

  - Instead of forbidding HAVE_GUP_FAST with HIGHPTE enabled just
    disable HIGHPTE on PREEMPT_RT. As Arnd explained, HIGHPTE is rarely
    needed.

  - Don't let ARCH_SUPPORTS_RT depend on HAVE_POSIX_CPU_TIMERS_TASK_WORK
    which in turn depends on !KVM. Since KVM has been removed from ARM
    it is sufficient to unconditionally allow ARCH_SUPPORTS_RT. Noted
    by Arnd.

Sebastian Andrzej Siewior (3):
  ARM: mm: fault: Move harden_branch_predictor() before interrupts are
    enabled
  ARM: Disable HIGHPTE on PREEMPT_RT kernels
  ARM: Allow to enable RT

Thomas Gleixner (1):
  ARM: Disable jump-label on PREEMPT_RT

Yadi.hu (1):
  ARM: mm: fault: Enable interrupts before invoking __do_user_fault()

 arch/arm/Kconfig    |  5 +++--
 arch/arm/mm/fault.c | 16 ++++++++++------
 2 files changed, 13 insertions(+), 8 deletions(-)

--=20
2.51.0

