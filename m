Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D5F3016EE
	for <linux-rt-devel@lists.linux.dev>; Sat, 23 May 2026 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779562290; cv=none; b=fD+21RqQXlNO8rRalILgv4akoGwmbVCbKkJjIHYsUTeqNL3Ito6GxaOjW8NK6Jd7XINyvb06H6/7Brjf3TeL9v+p+y7/dRPe40cVa2kVCdmZm3HF9mBTfM64vQDBtHptrkA6BpdiKn9gJsE4qrGV/bm+mRuoWcr4qfupT7b6yb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779562290; c=relaxed/simple;
	bh=b6NotZOB1n00yhayE/3jchuEn7PCcp8Favw0pvVe+KU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j3dmN+V3fa3hlFQ1tvpMKVIMnyXND3aBrl8yF1jXThHSsp4938CqODUak9OlGZ4df1QMqqM2oQDwTtWgAzS+iZu2XHu7NmDVt0wmjDQm9YYoPaEHYDgHuDq1cFEHCdkUKZKSkiy12jcJw6y7rGbINGJs+ppa9XeF26Mco8oCGks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoTpLhld; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoTpLhld"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so1899033f8f.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 23 May 2026 11:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779562288; x=1780167088; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aw5PnjBYdqxVdVY0ec7Tocd2myX3vnwFwBpIPJOFeXM=;
        b=ZoTpLhldlrxZjdbtmcfHt6jo1SG6fUGgAIyQPknb2Xfr4UWVS172A2qUAhn9fylsU7
         wkVTPzZWycwXBa9aum0f9Iy5WTHMXfM4pVG3AD2HoUZhz6GkQ5RiKau9kArak53uPjad
         IINI7lNLQ1RZX38CeLMFhntYJ982sLkzkc6DFWA6KiGLbPUF6ADHxY6JH5l6aDk+tQQ/
         fVkrsDNq89RFekEvKdUlYAwgW7IpAfr+yVawa/RNC5h7ZTk4Ln7AiOs4jF2WSzYePiOc
         K0L8Q/p99zQ0ebVvBsrTr4vyjZv1OB0TGy/tL1B031enf+2AeVKQOL18k3psmbImDNsH
         a+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779562288; x=1780167088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aw5PnjBYdqxVdVY0ec7Tocd2myX3vnwFwBpIPJOFeXM=;
        b=qKyHRC2z/KloEzKwstoeuyGzvy3D7NO2tjwawnKWPhTc8sZT2AE5vF2KSOfY1u0BMK
         enH7HAOdHMv2bE95UpeRvtsV2HJk9JXl4/0SgnYVMYIhvhKl0eU2mcKSJCPztKRU0dCY
         m22BXpb81lFdUWo1oBg87MVRu5NUCwWaDADozETcj5evkm3i6wo3P2/QvxAoAQDBOw5d
         udhawIyJtexyCV0Vo7KW3M2JxqpFHVAXqa/mI3MwBXKkpCs5cbSgpCAhcwiVbIA8CXAs
         rSdh4u94/2pXMs0hd4wKKVWJp0Zw+SGN8UZRsbz8/rqoO+OUUQKFokoUE6Il6SAAx3Gs
         fzTg==
X-Forwarded-Encrypted: i=1; AFNElJ/1eRlYB0KGENt//nXU6vu+ph0izJwCba+rUXiAkzrJA6v+laFzJVuqtGnwdfEf2Iz6fGISvxpAqIQqFts0fA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8Gr3W3blTSeqtH90faefhCgLSI7kZHirfzHTY6xtsZAG2/+tf
	U6VbLjd4v2kOh6VjT0KBbm1g0k+LDQ3p3apjHT0+8i6n+GasX18h5z72
X-Gm-Gg: Acq92OH+GrVtzh4EIhaGNbaIxPOGTwKRrNrsZkwYU+TQ3yjHp7YxIPaVIjMB1e0H8ue
	sVYoQHB+Hjrzc2o/MEphFXJSXZdzzF+mccS2iEfL3mr0Lo6mpWOv4hvyvZa/yi04lQ5tEL+3ee1
	bQxu2VWxC7hbDaBo6XZvBox9E4GoOcVfuS/E6UB0Gk8K5v5ZXN7TmfVVcUo+b9UvP09iwEepiQk
	Ou+DNdAjr9o/rPUReY0RVhDpT7WICHF6xwBxAER9NhB1VsuCABvgmBRPcfP2FjxrMVziE7Ha02I
	Ix5SrYHHMkhYNIm6X3/wBAWB9NG7a6JqyNtSrQOU+QAfulON9FVQ1mkjVG2paf0hh40KL6ia0sE
	7Ds9ElWJrFuCEGRCgLPDhBsE5xjxkS2DQr09TNzdVhiACc9HOE+FN2j5ti/Cw+OYJlF8Zgnf+/j
	kFty8/0PW1hoZUniVkmo0s1WPtb+xnwOmqKRy0ycGxecZluHSPvnheEwwUEfh+dooC2C/blvd/T
	4LZJepbfehSdtx6/Ij7qosmbFuNbvy356HLmzUV/GXXUQhzhtvBmIX7mAI3NTva1ndsGioz8ww+
	Y2snm2lnBrPyInvPeOTRJsyghGLIZqM=
X-Received: by 2002:a5d:64e1:0:b0:43d:77a8:3baf with SMTP id ffacd0b85a97d-45eb38af927mr13974624f8f.32.1779562287374;
        Sat, 23 May 2026 11:51:27 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a9c7-6b01-94ec-c77c-d65e-8d56.310.pool.telefonica.de. [2a02:3100:a9c7:6b01:94ec:c77c:d65e:8d56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9f6ffsm14058366f8f.1.2026.05.23.11.51.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 23 May 2026 11:51:26 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH 0/2] lockdep/selftests: Restore PREEMPT_RT task state
Date: Sat, 23 May 2026 20:51:21 +0200
Message-Id: <20260523185123.17482-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

the lockdep selftests deliberately run broken locking patterns. On
PREEMPT_RT, some of those paths also leave task-local RT state behind, and
dotest() has to restore that state before the next testcase.

Patch 1 restores current->migration_disabled on all PREEMPT_RT builds.
The missing restore is visible with CONFIG_SMP=n as a pinned-lock warning,
"bad: scheduling from the idle thread!" and a panic after the selftests.

Patch 2 restores current->sched_rt_mutex after WW-mutex selftests. Without
that, stale RT-mutex scheduler state produces rt_mutex_pre_schedule()
warnings in later testcases.

Both changes are in dotest()'s PREEMPT_RT cleanup path in
lib/locking-selftest.c.

Tested on x86_64 QEMU with CONFIG_PREEMPT_RT=y,
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y, CONFIG_LOCKDEP=y and
CONFIG_PROVE_LOCKING=y. Both CONFIG_SMP=n and CONFIG_SMP=y configurations
boot to userspace without the pinned-lock panic or rt_mutex_pre_schedule()
warnings.

Karl Mehltretter (2):
  lockdep/selftests: Restore migrate_disable() state on PREEMPT_RT
  lockdep/selftests: Restore sched_rt_mutex state on PREEMPT_RT

 lib/locking-selftest.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)
