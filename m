Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792646281;
	b=3S6EWyq+a10R0B13vRlfQAsOW+I0VtsWEz9a6xVTozwGiaZLhTH8CTIuGDrutl6jZXvD
	 i0INV05KUp7VlDao9ijvsChMJ0ZnF9j/qJKN8ZmEVQ8gx7r/xZWlc8h2efcoGQOpqfCFe
	 ihCoE3gXwiYAIrRxa1l1YG7S/z+7/1kMwIDat3ybnPO8XUePHDdY+RpzjxRvGzTc3pMaO
	 blfamNkhJsgxd5oNauaKUKfbyn7WZ89wrUu0Aj2m34TtTPWqDgUnP8mCjAoeANLfFNIdw
	 ub558WhdwEq58h3pDGjhIJ5drdkyIq7pUQiS9lnIym7MoDtRWiUECncv0sWUcFoBeWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Mo4ijoE4/zyX2xv2dQEbhTN41cna2GSZkZljd09Fpk4=;
	b=cVeejQvz+EGxeWVqsHKllVn4kz2fqxPDSWEgVRg1WSiVfMCZfeuFFnLnXNkwSwPPZyJ3
	 zEd+mi1GBgNoWiKfAHrK1QStsz4fsXzr71y+sbayFwui5SkVIP+K9Wj16Kk1bdNDZE4UN
	 lG3eu3LugjZY7kFWNIQKI9nkii/QyFLKQ5jJbr8ryApYBt4tCjtbEa2pvoUWA+5mSsAfq
	 mdCjRGqbI0UhVeXgMOLMo0OrBpyhCjgMVlH0JHrtDR99iNscLTUmWyNnnhJJTmmCQljDa
	 g5EAaWizSirOLKD+1mEscoOOjl2l+QWS97hraMKrsnNqSSR6LU0khg1mhHJ5wdvbD2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jDdQY2hi;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE12360A260C
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 05:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE12360A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jDdQY2hi
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a20568c8c0so2397245e9.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 22:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792646274; x=1793251074; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mo4ijoE4/zyX2xv2dQEbhTN41cna2GSZkZljd09Fpk4=;
        b=jDdQY2hisz8TMYWTI29+GYLOa+ORWtv4igvGXYnM07evglAEUnle7RxucKv9VJtchQ
         ogEJdcm79/wz1HSmOGHhod4gPvO6Tr3Saq5JwLdsaca0341egxvYHz6flfqsMDb7jMpN
         ZCRM1A6PMWcv0QtDBT2eg2ZfJGaZw47wuOD4tO3u1278s0jO2RcUjbS5OLyUaQ0SGXrI
         ivcqiqdmX9ALtjJYHLS5VafZl0bEdRltZsOKkamvChe9a4URkhUA4Ul1NpIqwmCmVEPd
         STlI/NqBFUwojMPR582S+KtAVWBw/ihKeCCk4mXj9G8ZUXpWJmNuGX+Al7lno5syuTX2
         2ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792646274; x=1793251074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mo4ijoE4/zyX2xv2dQEbhTN41cna2GSZkZljd09Fpk4=;
        b=uSoxjMiEDO9dUd/XvhNBZzDVxmBSvvsgOa2f18L/XvhNE7e23xRQ/ld/qj7rttt7B5
         PQ82W4xPCVfAcOMY5oRJ2kIu7Drm6MUjILmAw2IdVdkvPqCo6SNvx8VLhTbmazqbMxny
         TK6I+sbw4Ge1H7PEKDUfJfSlwX7rls0BQpKO+vDleaEJSTnqxbSghP3EUSBtlX9S0dHa
         dDVG8VP4X3Y25X74c6jqG9y3sG+fn5exCwfLmpwfpbba2UasuBpAj6wlXVvkAI4EOJWR
         j/PgCnyJF86QhC3+T07lAfam8GyVqvMAIq4Q1llrPBHObVbTKSA+Z4qiTKL0JQt0I5Sh
         WYHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzY66oTmsep/IcrvpZaBnKzAcJfE7f5Lu6A+QCJdJsLH8dC5Os1TVs8ANjtjoqNqWAOD5tYXXo16jumAKm9iw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLIK3L7hqAmtmUW6NrRuVyTGlnYQsMKl/ktvTIlwdKWZE++3Ikj
	7/PVu/QDTFZEkeeJmqNq323xfXk1c9tLuQIO8PTKhKmwCNMmVZhJLQyz
X-Gm-Gg: AYBFou2gwJHb0ylVYRAJ6/R8SfsiA3OoU1/3deo4sjgwt+Lc3PgVFd1WqzxbfmQ1QE6
	QwPz87kAcT+G7QfGQ7vN3PdTBeMw46rle2zkQtss0xMPd/J8loG0i3DFBxhFo3a8og9h147A2Fa
	7n0DXaXtt6fJzs4fBJG6uMBs4nDoY+rjYPT/ocI4QAErQf1baBq6++HIWvQv6mOxSx4Los1fSlM
	cGy2d99WWovGy+cARh8aq82AGRRr+0b2Kh9TJlxSAzBdDol/xAre2apCs5QNhvxf+QpkRp0+Yn2
	D09b7YAi6r/OxTS+Cb6T62U+6PBbX1vbBC7+BUCVYYYHnYxsvybwfRpqbzfPcQ75x3zZa0GwIZx
	ruDFaLPuJ8zV4AcfkKeL6yRVHFMD266WqWJqhALPt7Wu7hyWb5QNdVJ2/ZzEh0GNyG7b8xijcAT
	eknCsGDkxaLT0Y8lQ83aTkISS8sgS/TD04xoXdi0FyxclA1ozzHcItmiEg2fctV/TGLCJ+d8pir
	v9mRhVWKtpCyS4MrhPKE7ZKw+hLtLlP95sby+KbS7yuTh8QC5q2sXWG8sFh89gl/khT2CmwK7M1
	OdTmyZPNnTfQJ170ldyxhCzkU+53C9bEJPzlkpYdmlZCb01eGBBYLCQ6X9o8s4lwDgrXRmpdzyP
	NewdDDQnvjYm1fvpjkXNVWfO3Keh9vPv2ehL7diLgm92qoWRaltxPtbfWwfV7
X-Received: by 2002:a05:600c:1c09:b0:4a1:e00b:a10b with SMTP id 5b1f17b1804b1-4a1fdd2468bmr84667645e9.7.1792646274255;
        Wed, 21 Oct 2026 22:17:54 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm90362275e9.3.2026.10.21.22.17.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:17:53 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Hongyan Xia <hongyan.xia@transsion.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 12/12] tracing: Pin recursion state for its complete lifetime
Date: Thu, 22 Oct 2026 07:16:54 +0200
Message-Id: <20261022051654.79224-13-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261022051654.79224-1-kmehltretter@gmail.com>
References: <20261022051654.79224-1-kmehltretter@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trace_test_and_set_recursion() publishes the task recursion bit before it
disables preemption. Scheduler tracing can therefore run while acquisition
is in progress. Conversely, trace_clear_recursion() enables preemption
before clearing the bit, so a reschedule can observe stale recursion state
during release.

CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING also validates RCU state before the
outer preemption disable. rcu_is_watching() drops its internal preemption
reference before returning, and the warning path accesses
TRACE_RECORD_RECURSION_BIT outside the protected lifetime.

Disable preemption before validation and retain that reference until the
recursion bit is cleared. Balance both rejection paths. This keeps
validation and published recursion state inside one preemption-disabled
interval.

Keep the transition slot unchanged. It remains necessary for
interrupt-entry intervals whose context is not yet reflected in
preempt_count().

Use preempt_enable_notrace() because this inline API is also used by
modules. The no-reschedule variant is unavailable there.

Assisted-by: LLM
---
 include/linux/trace_recursion.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index e6ca052b2a85a..fd14380751404 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -126,11 +126,16 @@ extern void ftrace_record_recursion(unsigned long ip, unsigned long parent_ip);
 static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsigned long pip,
 							int start)
 {
-	unsigned int val = READ_ONCE(current->trace_recursion);
+	unsigned int val;
 	int bit;
 
-	if (trace_warn_on_no_rcu(ip))
+	preempt_disable_notrace();
+	if (trace_warn_on_no_rcu(ip)) {
+		preempt_enable_notrace();
 		return -1;
+	}
+
+	val = READ_ONCE(current->trace_recursion);
 
 	bit = trace_get_context_bit() + start;
 	if (unlikely(val & (1 << bit))) {
@@ -145,6 +150,7 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
 		bit = TRACE_CTX_TRANSITION + start;
 		if (val & (1 << bit)) {
 			do_ftrace_record_recursion(ip, pip);
+			preempt_enable_notrace();
 			return -1;
 		}
 	}
@@ -153,8 +159,6 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
 	current->trace_recursion = val;
 	barrier();
 
-	preempt_disable_notrace();
-
 	return bit;
 }
 
@@ -163,9 +167,9 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
  */
 static __always_inline void trace_clear_recursion(int bit)
 {
-	preempt_enable_notrace();
 	barrier();
 	trace_recursion_clear(bit);
+	preempt_enable_notrace();
 }
 
 /**
-- 
2.39.5 (Apple Git-154)

