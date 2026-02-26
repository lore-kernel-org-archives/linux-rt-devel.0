Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDBC364EBA
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Feb 2026 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772104677; cv=none; b=iO0KZ3hjAXzm/bVnJ5pcnCSyOoDsrscBwPQcDl0BuhWza9Dn9yCti7JZTaJb8DDjAn4itK0qvw2yeLXFEVo7FhkZNZX30irdM9CHjw80bd9I5dgogtJHR74LjbIsqqEBxIyhPtow4nyMm695J6HfC8LDwc7PAV2WfG04TYu65f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772104677; c=relaxed/simple;
	bh=CVTDMarCK3Haj3jCRSx1DoKpRxGNQxrMF0wysoCn6yU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JCZs2tbBMVEKmim1v3IvOQWYt5GNBkE619/+kIWUwP1pvHrmbddg/61fGAtvRmkN84/pSI0J9lnvXYtCWYxrZkSva2Oyfum0g9j0jYhCNlkv7pTFw+/bKPOSpgxIS3P/z2kQy6+xX1oFBpEtMjojxy6go3daKk0IH5mdR2uv69A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eQPIBagm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GruVQ9gN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eQPIBagm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GruVQ9gN"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772104671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r4SZo5uZC/P7ElPVfHiGmk8g1VraQoDmCXo/VdatM7c=;
	b=eQPIBagm5WlGNaY2x3fZ4Mmo00mFmCcMto9CX1ac5gTVFJDSEf6lZVXwvfefeIT7VTFG81
	tvd4WvsLqy/0mMTlcgZ2MJ+jzurCkek94xhwZfx44eQBMeC4FJhaq04udY2F+JNyub6ZTl
	LIh+x8AjqXD+5Wm7AWa6YxTT9fUkHofCGySf8+U7dP9x4s3d0KxEr4knAiZwA1SKFNDuP5
	durYekfm3vWSa3EeN+QhLoG8Q8aDPCZ9aWKEhH3LoXscE5wq05C5rWmjDV8ZxlWzvEKZZO
	PBaDB+wxYcM6yBQyn+2u7pSB/hSUhBDEK+c6kI2tUAq/Emp/juhG5gbG2KrkMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772104671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r4SZo5uZC/P7ElPVfHiGmk8g1VraQoDmCXo/VdatM7c=;
	b=GruVQ9gN0+uWbSd8aXX+7Ne4dz0SEOB/fPNI2joKzi4vVCKQsFlrZc5y1U49e3Q9ywK3N4
	wVcxo42NCmb2J5Cw==
To: linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Cc: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v5 0/2] ARM: Remaining PREEMPT_RT bits
Date: Thu, 26 Feb 2026 12:17:40 +0100
Message-ID: <20260226111742.3598421-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

this is the last batch I have to enable PREEMPT_RT on the ARM
architecture. It is just sending a signal with disabled interrupts and fina=
lly
enabling PREEMPT_RT on ARM.

Is this okay?

v4=E2=80=A6v5: https://lore.kernel.org/all/20260116170041.1059997-1-bigeasy=
@linutronix.de
  - Repost.
    Russell said in aWqZDwxUtaE1yP28@shell.armlinux.org.uk that #1
    shouldn't be needed anymore because he has changes in his queue
    which should provide effectively the same changes as #1. I can't
    access it. Here is the whole set so it does not get lost.
    I would appreciate if it could hit the next merge window.

v3=E2=80=A6v4: https://lore.kernel.org/all/20251110145555.2555055-1-bigeasy=
@linutronix.de
  - Dropped applied patches
  - Rebased the remaining one on top of the recent fault handler and branch
    predictor fixes.

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

Sebastian Andrzej Siewior (1):
  ARM: Allow to enable RT

Yadi.hu (1):
  ARM: mm: fault: Enable interrupts before invoking __do_user_fault()

 arch/arm/Kconfig    | 1 +
 arch/arm/mm/fault.c | 4 ++++
 2 files changed, 5 insertions(+)

--=20
2.51.0

