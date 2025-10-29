Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C7033CE82
	for <linux-rt-devel@lists.linux.dev>; Wed, 29 Oct 2025 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753575; cv=none; b=PXZaSo+PoicawO/DgWIu9k6k/w3UQRa1pJHGZQzubSSOj2o+vlzCq9Q+lKam6kOTP7vXE8HtGtnjpdAaGWJA9cJEq6G2ToBNziHM3Wo+WddJOthFIz3M7kdfK1ahdupBEEWZlh9U06nuW5gc2L1wa2Q/joGSQ1cs44Kg5fGeGQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753575; c=relaxed/simple;
	bh=DgmBWKGt92Rbe/1Qht6WyOnerJdXL5BIHrAfUINEIWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C5Za7E7nXcF7TXGaeN/lYBU17X8KsAnrVPQGUFVj4+NQlrBZSKoJnS4fRHvN+iyyC2Bk4VOWava6uMWQxt2W8x9XVRFpKK1wAPrjiOuRk3nDb7ioMyn06DAqc/hJyrda6bvZXER/bPYirBbPQ1wcojNoXfuxS0ikZuVU0HBUiss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I8VgbjUW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dfg7i97O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I8VgbjUW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dfg7i97O"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761753571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P7QSE5GitQoizTRY+UiaUB+DuiXQRLwxlaK7Yf2TPOU=;
	b=I8VgbjUWIFCSy9buZfGEyMySBhKNoAJ6VlFGMQfG695cIg9PUvjbLXz8mfdEFKAlAXw9VT
	ia21WhZz4sSjBCZPumK3wY6fgUNCLVjE6R4zYuXALP6IuonyPZqKfYqQsvlArQpd7GVDOQ
	IfeyN4T/TzbxjXfzHr0q1weAxsM6IQQPSFlnaRDoI53jlzLTe4OWhplajZnDfIg4Y7kjpF
	Bn3xzpvcdHtIVObcz9HoHPO+RwW/nX9hey/Lu8mOSlTKfYVI/3FxmVwhgb0Qf3RMHZu9xi
	CBEQvPll4AD5AyEdwLyJLj79HK3qimroQ715s+vvlkrcgHF4MaGiV8VQT1PWzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761753571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P7QSE5GitQoizTRY+UiaUB+DuiXQRLwxlaK7Yf2TPOU=;
	b=dfg7i97OZWnPJey5pK8tIADFa26jADWeUamW9j8gXgtfMqXeIvOyvvji1Ff+fKWdSuAlXk
	7ZulXM4OHL/MkWDg==
To: linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Cc: Russell King <linux@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/5] ARM: Remaining PREEMPT_RT bits
Date: Wed, 29 Oct 2025 16:59:13 +0100
Message-ID: <20251029155918.503060-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

this is the last batch I have to enable PREEMPT_RT on the ARM
architecture.
Last time I posted them there was some discussion about making the
branch predictor hardening worse. I redid it hoping it improved now and
does not make it worse.

Sebastian Andrzej Siewior (3):
  ARM: mm: fault: Move harden_branch_predictor() before interrupts are
    enabled
  arm: Disable FAST_GUP on PREEMPT_RT if HIGHPTE is also enabled.
  ARM: Allow to enable RT

Thomas Gleixner (1):
  arm: Disable jump-label on PREEMPT_RT.

Yadi.hu (1):
  ARM: mm: fault: Enable interrupts before invoking __do_user_fault()

 arch/arm/Kconfig    |  6 ++++--
 arch/arm/mm/fault.c | 16 ++++++++++------
 2 files changed, 14 insertions(+), 8 deletions(-)

--=20
2.51.0

