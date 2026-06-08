Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B003CCFDB
	for <linux-rt-devel@lists.linux.dev>; Mon,  8 Jun 2026 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928509; cv=none; b=Av53ueAQaAQvoI+ucPQEEeQTaGKc+35T6YpZdv1JEbbp9UxZGoVXGYk/sG/twy9C6jN6IVztq03OWmSkOKmUlor2SBA0mdVGTYF00EOF/syozhsfaH7IYnVkfXQNqN+Qw2JUNwvwYvvmqvX866ql/yaIpYOqZx+5zTNztRJoIw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928509; c=relaxed/simple;
	bh=5Nz2QAJkB/H07KyO3l85HCsLerC2eMRAuUu6NWvgaP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TIxkWgu3RmRNVI2c6abksGVacmMAVm3MMYZ4FdWCvi9Zsk0GMrXKOSlHOAceQux4dTB8CeoUAQ0cJ+nfxVy2un/NFrlzTolO+XRUTwc5Nd2HQo7xNGXAwyqHri0bFpEQY4VJBedomFElPSPzLnD/Q7pOHj1KD5utbUiYjPSFzUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=el+vOkJB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mGNnBco3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="el+vOkJB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mGNnBco3"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780928507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqnPZObhW4el9zMNUdbuV8wjUg6mwApi4YgJpKfJpE4=;
	b=el+vOkJBbblW9vNwJ0lvACMGa1jc2VWYVVa8nAo5vZRS3CWTwmB/trDi9ZZgK8DsT0hmra
	qe58VuHGmtd9DGTLZN6w2uxkuZW9NKfUw+d6uOQwakt60MgO4vMWAxKloqvVkoDjlieBDb
	gPyq+Gk2uig4IoQ2srngzAgF03MuKLM2OhKiEq4A7NuzmoQVLYV9kBDLIX5ji1aXKksg7F
	qug95E806KdQfFCTgNy9JXTGXvaxsyiK1zc6r0RvuPHtRKxTvDhf9j5dzU2id1WrR/Hvdh
	uNoAotW5Hso4r9Qo3K9uxfOVjqueuayTjFlJVNsp7BRHyMV+LQFfoM7knfA0gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780928507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqnPZObhW4el9zMNUdbuV8wjUg6mwApi4YgJpKfJpE4=;
	b=mGNnBco31usPDxHd3COCxIWmjhfV1A7xr9J2/jVs/wKMC361eHvl23XHetzItpOhsyZ7Ew
	kWpq86S2OWF7QVBg==
Date: Mon, 08 Jun 2026 16:21:43 +0200
Subject: [PATCH v4 3/5] lib/vsprintf: Use in_task() for restricted pointer
 context check
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-restricted-pointers-final-v4-3-9a436615799e@linutronix.de>
References: <20260608-restricted-pointers-final-v4-0-9a436615799e@linutronix.de>
In-Reply-To: <20260608-restricted-pointers-final-v4-0-9a436615799e@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780928505; l=952;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=5Nz2QAJkB/H07KyO3l85HCsLerC2eMRAuUu6NWvgaP8=;
 b=S6u3eOY7QuoEqaZMq8W1yEluiCU5E9tmqMWrN6JhcuAQF7txkMo3HNj5g4taS0nbZwKBPVDof
 RlKiO/+VQELDrgtmIWq15nWmsNyz/kN6BFpyMBOKCSQ5a5hDZ6UXowg
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

in_task() is a easier to read and slightly more efficient variant of
the existing tests.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/20260504130044.GU3126523@noisy.programming.kicks-ass.net/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vsprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 33e0778fca52..6095b5f0d022 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -874,7 +874,7 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
 		 * kptr_restrict==1 cannot be used in IRQ context
 		 * because its test for CAP_SYSLOG would be meaningless.
 		 */
-		if (in_hardirq() || in_serving_softirq() || in_nmi()) {
+		if (!in_task()) {
 			if (spec.field_width == -1)
 				spec.field_width = 2 * sizeof(ptr);
 			return error_string(buf, end, "pK-error", spec);

-- 
2.54.0

