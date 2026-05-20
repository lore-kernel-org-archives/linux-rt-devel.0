Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BCD3C2762
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 May 2026 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266427; cv=none; b=U8FB3nW//JoXm2Y3UxynAjYX6D8pyxG6ob5Ot38ObYoEPEay4/t2p8RSEsQjk1547dpdSGIKkyuPGriE0a6sd1sTgmDdHcq71wN6hxvTastSZBJZJMppkQ7gC0MaBNw5yQLVfO6+GBgyH2aTC1SMUGbc/sURQr9nfiV8zfCSR1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266427; c=relaxed/simple;
	bh=crtE/8KNOzfZF9Y3J+8u7c/EVSRwssDdjCjXNLyIIho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L5bJuosESMkI0HVyNAebNDGQQcxl7PTSZGv7MQ0lXK/8YlBrgCzvTthZOWTi+qyN/wYgi5EaegaKStkwe81GZw7NfhIdOb1XJqSsf3JZPI1h8ij7ueGnK0PfovFOIJ/qthUzQC/z5QlaHM9zn+gHoqyRf9iz/zo5oczlpsewp/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SLebhuAM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KTQl6S3v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SLebhuAM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KTQl6S3v"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779266425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NI3p6jPnca9YK1N0ePo0tzZy+m5ojwRnX88v2Fh2DMc=;
	b=SLebhuAMsckSdX7QPaOtAMhVJy0jXyBgc6cY6A2HO9cJSJ6j9Q8ZO+c9/qnu/vy71latbM
	TOLIO1z726J/hrox0MkhYx0FOMF0fTjUFFoHQoyXXwyvbb/d27GP+auak8V+pfXx4XMiMA
	FspEjzxjT5dZTa7XkGU/A+hpp8O+NuNmGtQY/wQTm8O2yBNI3z5JqFenu72VK7zJTRPaeD
	982yDH0u5BpjgBSzTlUXqfW4FywVX0rAGJ9pHb1mPcmvDOt996XECYMUu1q4bbkBAcoKGf
	/nE6QRYYTztf/dTLHd57WlxV2rdpu3n907Wawl76CNJnYwP3Sm7+ldtF/Fsdbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779266425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NI3p6jPnca9YK1N0ePo0tzZy+m5ojwRnX88v2Fh2DMc=;
	b=KTQl6S3v/XzfrDEEhJMLxaWEgwtaEgj588uufKn4CsWMWCjQBoiSS6h7mtwtN8Ch1bbhPy
	JOgok4T/so7AGaDg==
Date: Wed, 20 May 2026 10:40:03 +0200
Subject: [PATCH v3 4/5] lib/vsprintf: Use in_task() for restricted pointer
 context check
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260520-restricted-pointers-final-v3-4-76bca6a6ab3f@linutronix.de>
References: <20260520-restricted-pointers-final-v3-0-76bca6a6ab3f@linutronix.de>
In-Reply-To: <20260520-restricted-pointers-final-v3-0-76bca6a6ab3f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779266417; l=952;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=crtE/8KNOzfZF9Y3J+8u7c/EVSRwssDdjCjXNLyIIho=;
 b=zdGa9dfL4QJCxaxZyd08nnaXkrD5ClzwKelo0l3wVggxqC+QuqSfzA5hXss6obYMkR6b031nT
 t/zZB6T6kkBAd1s17AB6kw6HkfoTY75ljOpRTbv7+9qPHwgrAdxDYm8
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
index 021db95087fe..69dbd22f0e9e 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -882,7 +882,7 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
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

