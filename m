Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189CF2EA755
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Nov 2025 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786583; cv=none; b=d3FS9lrKNGGhTWeAGxvjnVuA9EYFV9elngyt39V5Yc76uXW5tHPbE6UxLLDT5N7JjCqjyS3IKxwore5seP/AIIpqyQNdAoQxtjV5x6QFSMmNvaOLNYoUjecuVzNTvoqChoY9LlF6feRltYzmqGR7OZJTYRX11vsQyydIAtJMW9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786583; c=relaxed/simple;
	bh=7v1TEDDrKxWZTrBfRp900GGo5uiRa9PaDhYCZRcv9m0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rMpI7nX8zZg8kPIYJPdsGCOaOWh5vKJDHSOx1eUMiTzEQFmfCVMTiWEqNb7Ls4VBLDTq4Ri68h4HGRSkFa/ifzn7VkJD6ddfOvUPXz/SCYH4RqzZyeMVwOtdERSTkZOv3O6LoWnqL+QmvC2neiHLzzF4kbJBnIrdeg6UUIn8fTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cDtieN82; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d/53tPbk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cDtieN82";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d/53tPbk"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762786579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vd/3FqZBEmb3t88zXyTeUc/Fqx5bvAc+Cgy+ABhvCx4=;
	b=cDtieN82wpdjhzWTPsUOfwZG/p/1+oKraQcT/cbsAlj31MJty6qZD95TIDMDW7dOH+uBqf
	QjmF6NYLuOPR7x+HTyN1n1qc+Zv28p/cyeEDO25RSDhgdMMcNsHsOtKa5l9HM7QRJPZnK2
	eE0z8zPm9lrFYpaMAqxHjPc9Ojh9m4BUM/tr0hxLbk7e39GZo/r2kFWnGBkGmBJOeZReJD
	BDTe+MKaZgnQAIX+nLsxhxCVjk7mP2d2p4EoaNO3mqee1AHG9rc50wygEMIzANos4tgZfb
	0cL04Al0XP9huXLxT42fq3qvgnUnAZ6psvmFX5rbThnVNGxiXl5z5OskZySELg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762786579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vd/3FqZBEmb3t88zXyTeUc/Fqx5bvAc+Cgy+ABhvCx4=;
	b=d/53tPbkWQciAgJehnDhruamFYelbOrDDuj+CR34h0Hy9PlvA4ShfTJj5Z2kiVth0f+rrT
	nbTQICMv6dJrJfBA==
To: linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Cc: Russell King <linux@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 0/5] ARM: Remaining PREEMPT_RT bits 
Date: Mon, 10 Nov 2025 15:55:50 +0100
Message-ID: <20251110145555.2555055-1-bigeasy@linutronix.de>
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

Is this okay now?

v2=E2=80=A6v3: https://lore.kernel.org/all/20251103101545.760243-1-bigeasy@=
linutronix.de
  - Collected tags.

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

