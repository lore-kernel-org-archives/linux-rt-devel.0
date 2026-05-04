Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BA238758F
	for <linux-rt-devel@lists.linux.dev>; Mon,  4 May 2026 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777891647; cv=none; b=Jt8sEUFxSSrEkHhzmtpclt1BvPZSxQGtL2qe4OaB8VYJ5jATu27753LyiXghBVyee+wrYmU71Zn2GMoK74J+HN/55LkgjHDXCPp9maehPlOSgwNUJvktjtBfb8EMzTp7AdAj4GS5RjxOezv5wswkhJ5ZxA/7Hxe94HXnXeBSbWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777891647; c=relaxed/simple;
	bh=lmJI8f3u9B4G7FciLYp0kWkOm9BVT/9OFWxzVqecATA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f+hvH70X4y8ALpl9wJPpdFhOg61kjdW5G2vk85q3gousOHwYUQKpTC8hUEULfHcTApq43F+LJZhnPae6+KOPDDEsldmbBIO7VIdU6e+KttEcIreNvpSuj0xXhNVCBS5uPfLprACtZtkx0IJdN4CuXsZzc6hH1nWKdTU6G+tAZJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NX7sUq9o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mhPfCzgu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NX7sUq9o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mhPfCzgu"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777891644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LXGRXU4fmRF7IjrfEzmWDVsMblIm6bbWXcUP6dnm5sw=;
	b=NX7sUq9oTgPHLlrhQeqKvx757RJ+8iyw1c5iIap227KZfqk53B/Zn/I/WXDRyMR30cmhPz
	lKI2u8iCS02wm3LYyONrYrL/kyMYu62kxMBZJOtBdsDehJu1SfJBlCCdRskzd+m9UR5pOg
	IM32wpkSypHjN8DrH64KoXBbYqfs4jrF2c4tUsrt1D0zxCnipSt8DL8Sh6L32BjehVVocB
	OiKAVPHnibGqWv9sSWVWcQTIQt6wVjVX1cxERMdDh3Awm3GNLMpAiJn+qvNm2IS0B6aUAM
	G+/P/cAEDp4KsOb48x8OFsDrbPLkXunkxHKqRJInzDQctMFIo5B2B/4G4V/Uag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777891644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LXGRXU4fmRF7IjrfEzmWDVsMblIm6bbWXcUP6dnm5sw=;
	b=mhPfCzgu1eJ3HI4KBKxj48FjLtiHik4fMgmcPmGF9R/p54Zu/bQdpX75gqLiI8VO2afD5z
	wsmoQTSRLwNv2WBQ==
Subject: [PATCH v2 0/4] lib/vsprintf: Validate spinlock context during
 restricted pointer formatting
Date: Mon, 04 May 2026 12:47:16 +0200
Message-Id: <20260504-restricted-pointers-final-v2-0-4934933503e5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr2Jm7Zi2IIgr72FYYDvIJKQl00owh
 Ltbce/yveS/v0IkYYpwPawgNHPk4DOY4wHs0PknIbvMYJSplFY1CsUkbBM5nAL7RBKxZ9+NaJ0
 pm7rpXX02kPeTUM/L3r63mQeOKch7v5r11/6qhf5XnTVqfJTOdopcVV6K28j+lSR4Xk6OoN227
 QNC7N+/xgAAAA==
X-Change-ID: 20260107-restricted-pointers-final-cd24979fd752
To: Andrew Morton <akpm@linux-foundation.org>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Waiman Long <longman@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777891643; l=2212;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=lmJI8f3u9B4G7FciLYp0kWkOm9BVT/9OFWxzVqecATA=;
 b=VkyyezHC5U0/nGa5kx7yVNzyFEH25lhKaN4EkDWHhgN1ozPImWSdcA8O6hu6NKBD6UzhXBTEI
 Lob5pXaot8jA0O2YdDbTuAaGl36DLO+g8zpXrFqBWwg5k9McK3CRAOi
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Depending on the system configuration, the restricted pointer formatting
might call into the security subsystem which takes spinlocks, which
might sleep under PREEMPT_RT. As %pK is intended to be only used from
read handlers of virtual files, which always run in task context,
this should not be a problem in practice.
However, developers have used %pK before from atomic context without
realizing this restriction.

Add a lockdep annotation to unconditionally introduce a fake spinlock in
restricted_pointer(), so lockdep can detect misuse even if the current
test system configuration would not exhibit the issue.

---
Changes in v2:
- Use custom lock_map over might_sleep()
- Also assert IRQ context
- Link to v1: https://lore.kernel.org/r/20260317-restricted-pointers-final-v1-1-b4dca0ed6483@linutronix.de

To: Andrew Morton <akpm@linux-foundation.org>
To: Petr Mladek <pmladek@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
To: Will Deacon <will@kernel.org>
To: Boqun Feng <boqun@kernel.org>
To: Waiman Long <longman@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Clark Williams <clrkwllms@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
Thomas Weißschuh (4):
      locking/lockdep: Add a helper to validate the locking context without a lock
      locking/lockdep: Add a guard for lock_map_acquire()
      lib/vsprintf: Validate spinlock context during restricted pointer formatting
      lib/vsprintf: Always check interrupt context restrictions

 include/linux/lockdep.h | 11 +++++++++++
 lib/vsprintf.c          | 13 +++++++++++++
 2 files changed, 24 insertions(+)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260107-restricted-pointers-final-cd24979fd752

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

