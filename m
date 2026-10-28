Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158305;
	b=IlhgAfYcReLAxwh2C5zjXqCCb+I5n/6SYR7QEsZgEVS5HcKyQ46gWh+tBMYCS3FYpeTD
	 Eix7ESqJAATSvNgsDHWAJ4xwPqN8RcAE8HTzjcfh1ifBblcKjCMIuw9HVdwBr7CD3X6gK
	 3ccJDxidvTYtbJVfWOHrku+6XBeeEoe1xpWWwji02XiLz8ElyrWdN3kd6y6uYLQL9MoON
	 Iq4wy5FJvyzW3SF2SslOn6DSXn+HRcn6Ry5y8hjNUrcxpza6laPWzwW/A0tCTl8qFxsnB
	 Zu0L1jrsPgf9xygquvS8BxPIXm6exALwD7RrQGcjGLpZ/z86id1jUwyz8jEVvtrDwdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MfmoCWntxjvUsJ5jQdE0fli1C/EPjSIgsdskzAxULLU=;
	b=KFZJ12cR0mLvjXEu8VJ+AHMTV6tG4ndujj/UzFj2UFJ+0iLVq9F4Po4tYkb3PW2PAtF0
	 e1JHElaXC37fiy6vZA034jHX3asUhYTXDwNDC5Xh/SEi5+QMlKMOG2ZaU3L3mXA2AsCQv
	 0W/zpKJkPfxXGSCpBa5ino9R4purusvdjoCu5Kedput+cR/F51TnG9oHJnWWkJPgNQcTP
	 uthh0jEVEgWff0CyY79+y/TsfYsaqd76XVpuFLEiXYbcT70taR1VAWGDDlbKASzdrQs1b
	 OVJBzphWnY5YoSnuZ3ht0tG4nGocuCakBttrg9v3kjsk5XODskgqnAqdZ59vUIUOt+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="DwI/Ydqb";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C881606A31D
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Oct 2026 03:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C881606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DwI/Ydqb
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso3042625e9.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 27 Oct 2026 20:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158304; x=1793763104; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MfmoCWntxjvUsJ5jQdE0fli1C/EPjSIgsdskzAxULLU=;
        b=DwI/YdqbIM2W+EyLRmCgfYJku9HBYIQDSjcnqYIIptnMa284z9OMoGhecaYySt0xF/
         stpBo5TwFzJYRWvCY0MIE4Kq9mFPfFAK8n2xeafh7Khm046MpJFwgWng1a5nMM2qOoO7
         E/5s+CS/ab0HRdyaD5hiu/Cg8/veIUckAnM2KV47uKz5Gcgq8peaD691Me2Mke3PAddR
         z4xLWkAUoEMRQlclRkCXUKz733lx+lLI++DZ7ayQCNfLWN99vE38cnnu9QwkfzmKf3XQ
         ER1kW2btSrgKO2EWz2TZ69G6oaRebcIZ6iOPoO/eTpZP59Tek9F6N4IFSaiCcaBim15i
         3bAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158304; x=1793763104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MfmoCWntxjvUsJ5jQdE0fli1C/EPjSIgsdskzAxULLU=;
        b=IR6cQe9ZdrSFtUvop5f9+KgowmEndz7KLdGRT78SywfIvWIPFXreuoGVAX6w9dId9c
         ZtKeuXyKgrJPVih11uPWX6qTpBw3hl+B2eFgMG3jk1ewIFU8mr8SYJTWguS2cV1mi7uj
         lfaL8Bx5nRflGEoRRpsrIyfYp5INh8E+odSwqCq2zPInqjxQE3lq5kHOoKAI6rI4ryIS
         eYd9ze7OsaqovWRGJnE8jIczoyOIPsep/2V6p05RG2ZTydXrbQn7wpsP6gf6TFeSQPiE
         +G1xwnd5R3x5Mrf+rXRr/i9O3pa43QRj6XWRkzlMEgXllIFVNgbO+lbZTNAjJOWx41rd
         T4/A==
X-Forwarded-Encrypted: i=1; AKwUvBxgnxM+FFUQmpPkOrsekdoYhj0dMF/cVtOJJVHUlHU4LWco9JK+0LY1h0kmeiO7/5GZsZRBTGPIZYrhrL7Lew==@lists.linux.dev
X-Gm-Message-State: AFq9FYIrK1YLbI7FFH7N8Xe1++3hEdYMiPBUg9eIjiG6NJbQNgLNGgpu
	IUlrbqMk9VBGb23/UxCNOoxqzirVhvlEDj4x1fdEOPUre/Y+S6pfG5AO
X-Gm-Gg: AYBFou0TaIFrgVg5USaeB3Z1WSRElIva8mGSGn0d3cNexGjtqB9xVFsGsTz4AlroFCU
	FNU0Yw573RcYYIQwUzXFfDI5qZxsOCsmXgp4n6657bb0ZF3XhugCVp8x6VsQNt7HYKrai6ejFEm
	2ANSMLiw09H1DMGagr2LiXPNLFkpAgb7OC2KAo+5RRcPubs1BHh27ejzLrP3hIz/f2VdPndNhW6
	HZWUN9m5ZcN3K8xaKBzaSU6SeY41tl8DeO32d/5IYxyVJo6/HM1QrP4H7s/k3VJSJ9ZGlyb/5Ac
	+edsRTn9DZ8wh9mbhQP5jEVKlvKUsqf+7gfJklVMQ7VzuL/YYIHzIVnOS+4iTtbVFrONd3cYihX
	12kGZEr/pLM8rEs6W4DGxXzhF7CIZA6VDj/9yOg217eZxWdCnqbqV+SKBMSdq+c1gpCXdCHmY7N
	PDPfRvj68u4Sfq7vDY+VDzunXxJbLcpJabp5/D5osdQ3PDmRd665fC5r4svWeJb345O6mDmU/Sy
	VvB8vX8vZFSCnvxlyJlomimKyLp+QkTFEigvktBnXoidetaH/LvZDYdXwEllYNj98EiupsXFY7y
	3VtxzvbHtz3A+nNOGpdSokr3AVZEbY+ekz5OnRxVjPlwmjd+ohIebK/uxQMKpD4X5wNfq/FSvfh
	W5wevsdxbFzVCqh76kJyv04VEDQAZCXzYVjv1srgwwhVMzMrfyFSfY5TxGJrJ9NE9cjKPpqBxV/
	GfNzJySUUBsAqXkzAl0KeM1Ab0X1Q0dRuK
X-Received: by 2002:a05:600c:6206:b0:4a1:f377:5c68 with SMTP id 5b1f17b1804b1-4a967e8c07cmr16606825e9.34.1793158303715;
        Tue, 27 Oct 2026 20:31:43 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm24290569f8f.56.2026.10.27.20.31.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 20:31:42 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Hongyan Xia <hongyan.xia@transsion.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
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
Subject: [RFC PATCH v2 01/13] arm64: Always inline raw preempt count updates
Date: Wed, 28 Oct 2026 04:31:15 +0100
Message-Id: <20261028033127.82193-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261028033127.82193-1-kmehltretter@gmail.com>
References: <20261028033127.82193-1-kmehltretter@gmail.com>
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

From: Hongyan Xia <hongyan.xia@transsion.com>

Clang can outline the raw preempt count helpers from noinstr callers into
ordinary instrumentable text. Force the add and subtract operations inline
so entry code performs the count update in its own noinstr section.

This is the preempt-count hunk from Hongyan Xia's pending Kprobe noinstr
RFC. Keep it as a separate prerequisite so the early-hardirq work neither
hides nor claims that fix.

Link: https://lore.kernel.org/all/c3a90368dd6c096af9d918e036a27728696fb8a4.1786603168.git.hongyan.xia@transsion.com/
Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
---
 arch/arm64/include/asm/preempt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 75a592b7f47f7..f3a5c2cd1936d 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -41,14 +41,14 @@ static inline bool test_preempt_need_resched(void)
 	return !current_thread_info()->preempt.need_resched;
 }
 
-static inline void __preempt_count_add(int val)
+static __always_inline void __preempt_count_add(int val)
 {
 	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
 	pc += val;
 	WRITE_ONCE(current_thread_info()->preempt.count, pc);
 }
 
-static inline void __preempt_count_sub(int val)
+static __always_inline void __preempt_count_sub(int val)
 {
 	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
 	pc -= val;
-- 
2.39.5 (Apple Git-154)
