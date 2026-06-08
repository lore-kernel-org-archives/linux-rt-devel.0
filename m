Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F49A3CB2FE
	for <linux-rt-devel@lists.linux.dev>; Mon,  8 Jun 2026 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928509; cv=none; b=drrtTEFBF4dzKBjVaTga+yOr4rVHP8sgf2cPK4qoM1f0+svCu05438kFLONaxjbluRIxD3pX2A3avCuNLeXwpIETYIbZ1C+Bd2YVVEpoWonbuI3rHoOWH8KUBTUE+23/vBflVx6LAcH4ZR1YPPWkokLjLqldfbHV9EYlSt2ahIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928509; c=relaxed/simple;
	bh=FJxV01tY0jYQta4h0DnBakH8DsZakts8pBp4K7+TcCw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cI+OEQ1GI6rSoQ1mNcI8CMX6KHCWauutpFikzJMb2qOlhp+4XGJ8UspZ+zxo7wP3C6ghn25/g0GG4agTSr6mhtotn0kWJbxmOvMP3lT918M6e/C9K3brOBrkMYHWTyEyGdVVRvVGW9lK6OY9JbI4ZMxWdIU5kACp7GpF9VzkL+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1LDUY3ma; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fIIBxl4P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1LDUY3ma";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fIIBxl4P"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780928505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=usnktODvqGHnjFB5Th+zgOCRsQvGFC0fUHhZw1UCAK8=;
	b=1LDUY3maeOwweh4yvAunMQsYUgMOEGLWuG96xO9nganfV1mswVWVYs/sU0wWya/FADsP2E
	fyxG65fek7YiPKiGnD241Dc5f0BeLq2FGbEBLzqCSdvPbPtzftJDZlWMfv4kRjM9KnvA5o
	QjOxWWDc/j3lw8Es680DYYBSLCNIcgd5YRIUSIKjaPa8aF23SvzyKlaBoXhduQYIXfKj1u
	Dm3gAi8ExKWoztoECoyOUHHZmmFlm5sLzcQC/+V9P/dhUC/2ErTnOwQHtemImbs/kK6OSf
	5dKlaj/NEHBzLDrR78l4bmST4kg4Zjpg2WKp3f71eegwIFkgYmduOTnhfYMNfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780928505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=usnktODvqGHnjFB5Th+zgOCRsQvGFC0fUHhZw1UCAK8=;
	b=fIIBxl4PRean9kfYkLm5QVSyNVaMLD0F9rOS41y867fgtuUWrDXXxTo6C1P53aHwlQNVv/
	KLkKat3SgSf5gtBA==
Subject: [PATCH v4 0/5] lib/vsprintf: Validate spinlock context during
 restricted pointer formatting
Date: Mon, 08 Jun 2026 16:21:40 +0200
Message-Id: <20260608-restricted-pointers-final-v4-0-9a436615799e@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTQ6CMBAF4KuYrh3TP0BceQ/jAtpBJjGFtJVgC
 He34EJjDJnZvJfMNxML6AkDO+0m5nGgQJ1LQe93zLSVuyGQTZlJLnMueAEeQ/RkIlroO3IRfYC
 GXHUHY6Uui7KxRSZZuu89NjSu9uWackshdv65vhrE0r5VJbbUQYCAWltTcbS5Pqrzndwj+s7Re
 LDIFnmQHy3jekuTwEGXKq3KuMLsn6a+NMm3NJW0Iq9NlaepVfOrzfP8Al1r0pViAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780928505; l=2812;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=FJxV01tY0jYQta4h0DnBakH8DsZakts8pBp4K7+TcCw=;
 b=JXlTB/UNg3yMYcpQk5lOReikqd+pImjjbkSvclLRuz8MoxgygvKVF11EGuYqI16MToH7Lg59l
 Ac1hDZP4f5qCbQBMrpjqL8906zNt00b9OTjuHmYVNfN7sBt2u0gEanr
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
Changes in v4:
- Pick up review from Petr.
- Check in_task() before LD_WAIT_CONFIG.
- Make commit message slightly clearer.
- Reorder patches to avoid problematic temporary states.
- Link to v3: https://patch.msgid.link/20260520-restricted-pointers-final-v3-0-76bca6a6ab3f@linutronix.de

Changes in v3:
- Use in_task() over its open-coded inverse.
  - Also switch the existing check over to it.
- Link to v2: https://patch.msgid.link/20260504-restricted-pointers-final-v2-0-4934933503e5@linutronix.de

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
Thomas Weißschuh (5):
      locking/lockdep: Add a helper to validate the locking context without a lock
      locking/lockdep: Add a guard for lock_map_acquire()
      lib/vsprintf: Use in_task() for restricted pointer context check
      lib/vsprintf: Always check interrupt context restrictions
      lib/vsprintf: Validate spinlock context during restricted pointer formatting

 include/linux/lockdep.h | 11 +++++++++++
 lib/vsprintf.c          | 12 +++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)
---
base-commit: d870b998ed2e4184cbe312f4a4e2fd60d1360caf
change-id: 20260107-restricted-pointers-final-cd24979fd752

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

