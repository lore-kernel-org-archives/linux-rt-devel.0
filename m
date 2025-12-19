Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BBE2C0F9E
	for <linux-rt-devel@lists.linux.dev>; Fri, 19 Dec 2025 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766134695; cv=none; b=W4T1AzOhlZ0zm8bmhl+FtG14hD2U4ZEcyb0bTvg/2rXMofpdUSoBPqIbwuFdhTzU09io/zwqCHdn8rmXTNMfWenk9XUWsXVzarrVaaKaYerwfd2GTp7yLBjb0u2/WvUT3KqVXyLnq3qnKJ6OvzEhvs7FS1YDRCDT8HglvEc355c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766134695; c=relaxed/simple;
	bh=78PzcjQ+AsGCryDCFQvqrBJyAR3tARFg6lYEek1qsrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gYRKbqk8Lbu+EMSXgPJL5QkaCWCJ9Wuer6v90/fYGpE8lkDPaNldzMLMChKqMbO1CiByhgqkH0S/EkWPxJm5SQC8yjSnBdEGi2dr9gQWT4xSGLGl5lp6kSrzYjdGzRUP7I6QsFp6a6KKPAgcrbuBt5GQwJNeTNukI/RjO49X6ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVRrvVdW; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVRrvVdW"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c3cb504efso1611010a91.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 19 Dec 2025 00:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766134693; x=1766739493; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BS6pQo1nc+d63tlPqPw7f84pjPfGdl5sB4EEvmyUkd4=;
        b=mVRrvVdWe45CSDF9n/6xpj1D1imsE9ekuLSgM59WU0XV8yQNpH/bYVvCCzPm/uUx3l
         /6DHRzDLoD3RS9woKHQyptcoN/l/1TyQE6wbGBRNjnSR5wd4+gw+QfDb6KrzNJuK0KfG
         7P7wqrW9nA0klwmpM4nKalF+y3f6fZ/vKNuJHlcQRdkhTNwmAxkgDq4mnAGLnmdRsEI4
         Yx0A/oEiWe8G0FRXo95ldVlqOs2JVhFyg7rFKVIWr4gVi7QaacnVTsSOljaWy6dyFZhH
         o4E8D3+tXa6R7XUltvayzz4ZI+vNuAJQNJAS3e9l3TT1OUoeg5uAgAaRWA+9ynFRT0Pb
         zd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766134693; x=1766739493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BS6pQo1nc+d63tlPqPw7f84pjPfGdl5sB4EEvmyUkd4=;
        b=mBmv1kC5kLYRhU/BBFIG1JWjRzXS82Lu4QJJCLTU/4mQ4mQq+OuuACJPRYYxVKB8dG
         lp8okV8Z9Kaf7DwSPqlelQzam6CmuyRHj2omqMmK5UNRM//gWmjBUVOuB65ynrFdu4sW
         e75BH9vXpJ3KbjuYKVEULlqAWZKxz09qZ2E5vk00KwK7hvWA4vfjXEoZXZbxt3hVJehv
         tEaNuzlrs7zixnW6uG49gug6MyjOzw1TA6PGDd+Gsjlv4I4AA/PlIOwHqZveUoiMWY4V
         gambAFMg8j4vclxrCEBNwcbx/6g7efQkHEpvr/7YpVd2r8cCOWFmWWtzjB5pTSGNiwLi
         pGHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf7nMeA2+k8rNraVPk/hpafCYezrQvXHJ8liCXBhpdrgtyO3jNXNKVhmj1iHmt2/ECPWZBCvcE6M0MBxdyuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGDW0XDDRfCq8ORPqkPl7+QzMXbsYAjKkD5OTFvN8BwjxYUs9d
	/8DDtJ3xuz6OPH/X13lAleNn6x3yyTDws9emJXYjIQzyaGV/dtEvBqJH
X-Gm-Gg: AY/fxX7eM+a695m4mTN94yhRjZ52/EirPyfyWdJWl+jA6GfjH4J9B2S2uX/39ziCP5q
	59yUG8xirM7rdNEBIds4pgMEJwT1h0jBY0Iss6d7PjD2USOgVuei2DPmrHFSd1KHl21ozT1OAyl
	cuOBuRZ13eU7zCXCc42qdjKJ2ffNQUC5ry6OvQ73D9WroGSU9TgzYvyYzS6BVywlEqVcyW0h2LF
	853b0x9D58WLeuZzq9laXARPwpv3z2JNZ3oyIvv7g1OmB5Mj9EuuP9iN0QffXEhB8hFJse++1Kx
	AePcWLaohA8u32GBZ/WoUZiJWqi7v5s0iqs+OCcEg8aV6OJBOnD6QzPFggsbm6TvQg4FnPFhez6
	1Ya1poLhMGzOqdRRP7dgl+o6GqItbtsvdNhBtwqmfdTHZAz2SUf3LPp/teqVmdnpJyzw3FkMipY
	H1N7F9+z/5cKgqjm6rV9Zf3fYvqi0H1w==
X-Google-Smtp-Source: AGHT+IF32G2wWGBiVL5oeF6GawusnMgfMsYbsd6xXnmx006whhvQHqj/Zsa1cET2gHQWWlVoFrxiVg==
X-Received: by 2002:a17:90b:1346:b0:34a:8c77:d386 with SMTP id 98e67ed59e1d1-34e92139a88mr1751290a91.9.1766134693272;
        Fri, 19 Dec 2025 00:58:13 -0800 (PST)
Received: from LilGuy ([2409:40c2:1162:1559:f712:85ce:d14f:d48c])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a2f3c839b7sm16474475ad.37.2025.12.19.00.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 00:58:12 -0800 (PST)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-mm@kvack.org (open list:SLAB ALLOCATOR),
	linux-kernel@vger.kernel.org (open list),
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	syzbot+b1546ad4a95331b2101e@syzkaller.appspotmail.com
Subject: [PATCH] slab: fix kmalloc_nolock() context check for PREEMPT_RT
Date: Fri, 19 Dec 2025 14:27:54 +0530
Message-ID: <20251219085755.139846-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On PREEMPT_RT kernels, local_lock becomes a sleeping lock. The current
check in kmalloc_nolock() only verifies we're not in NMI or hard IRQ
context, but misses the case where preemption is disabled.

When a BPF program runs from a tracepoint with preemption disabled
(preempt_count > 0), kmalloc_nolock() proceeds to call
local_lock_irqsave() which attempts to acquire a sleeping lock,
triggering:

  BUG: sleeping function called from invalid context
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6128
  preempt_count: 2, expected: 0

Fix this by also checking preempt_count() on PREEMPT_RT, ensuring
kmalloc_nolock() returns NULL early when called from any
non-preemptible context.

Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
Reported-by: syzbot+b1546ad4a95331b2101e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b1546ad4a95331b2101e
Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
---
Tested by building with syz config and running the syzbot
reproducer - kernel no longer crashes.

 mm/slub.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2acce22590f8..1dd8a25664c5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5689,8 +5689,12 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
 	if (unlikely(!size))
 		return ZERO_SIZE_PTR;

-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
-		/* kmalloc_nolock() in PREEMPT_RT is not supported from irq */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq() || preempt_count() ))
+		/*
+		 * kmalloc_nolock() in PREEMPT_RT is not supported from
+		 * non-preemptible context because local_lock becomes a
+		 * sleeping lock on RT.
+		 */
 		return NULL;
 retry:
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))

base-commit: 559e608c46553c107dbba19dae0854af7b219400
--
2.52.0

