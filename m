Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB434052CD
	for <linux-rt-devel@lists.linux.dev>; Thu,  1 Oct 2026 04:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829741; cv=none; b=Px8Z0uDKL3YnWZo685ZRqCdg9Sx52olmzkKIPkv/M3g7W36bl6hsAHXD3LLlzseZqxjFadDKdin4KG0PTIWYK7y0edmnIfOIVWSTSdFhn2fV7K4UVuXVFNh2+3GFh6qmtwBPckUUKCBepo0s/8JL60AqTPoLK7pbZgYtQhwN1Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829741; c=relaxed/simple;
	bh=SS7j2Mi3g5GlPry3bUdyss69gJmE53mV446QuvJzBYM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XyXSFeP9ql1aqSuxZXuaryYJXfm8KMTrr3MXUxnpRZSsXK1BZL9J3ku33v4U+3m/GY+qntxsSGCPL/9HUSfSiD1o4PvQJ4tsSJtYKG2vqJEyQXp9Yz5GePSO7QzAJKAYRoT9F4ZZauz13VSguUdjHrAtlLz772Moqm1s+rRO4QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBy3NAaA; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBy3NAaA"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ff9642c57so11796395e9.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 30 Sep 2026 21:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790829737; x=1791434537; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a1VMb1gdkAzPRn13HLN7Aa+0FwFU3dz+Af4Wv7wExRg=;
        b=DBy3NAaAq93CvTh29z/FElEvEGXUpOn3jr0oPnMlPbEUfwnGEn8LvsLT3YpmG3LVCn
         PhNxJloDdVoZORANHrTiTTy1SPuNjtLiL3hltHWeqDEw6/yLJT9dveH4hV3R+9P2BT9j
         6oFfQnUVQ8i75i0RPXJZXyXoBDqbyTfrKQsMrVIZs/sD6iBkcE+Gkp8govSycHN+Kb83
         m7CjZWuCXenV9jWuVgRLRHY35huzaLnZd2k8i6xv2bRo5iXgW22OEUjS1ttoDZgLrgJ3
         ePJCjwKvVx2Hn9Ilsaq/fErNN34AUZRMbNgya+O4n6BoufyPnQ7vYERIPw7uNcXvqjFd
         R2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790829737; x=1791434537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a1VMb1gdkAzPRn13HLN7Aa+0FwFU3dz+Af4Wv7wExRg=;
        b=T1rsozXI4uByYwpvUHFFmUO2vemSSMI4s370ZolJ/dALctbVCvlsEatJUsuGXnnEZB
         9vRLS9WkdTRV2mioRk5O7rgbGee0BvcpBNZ51BqQ8qq6BvFcrPuH48W0Nuo8HpyQEjFU
         gyBpBHjKN5DpXxDRUfxusKK/80YIlOR+jpU4jwUIveLYdAQ1/mTK5Y7xctTluRd7C8mE
         kMAHFilfXqtwrOzV+a0GenMHNKxfIZNEFn0IWkvF1Ydb1I1i3+8UwOPyMBHEmjxTLqkQ
         tspHum2A0nlGi56lKzm0ENXKFp587hTLdKBhOu6R+lPsmCxh58cSPOghw838IVnJt+fS
         ZU0w==
X-Forwarded-Encrypted: i=1; AKwUvBxjl6HoUy35vczTBKW72hVe4Y3JMlgB3LpkqOYd+8pJxZe9Fd7jCcOMpCLImr7dEHGbusshTpPi6HDq2kGyQQ==@lists.linux.dev
X-Gm-Message-State: AFuF++leMi1rFlRRYoH0M/HhOkYxLUPWcCCrJ65YkKDAb5w4HePihEoY
	xe9c3CgGP/OXO7EBQ6tJBjihhUwXfDAQGSHudbicFVs9ggpwSSn9qifu
X-Gm-Gg: AYBFou0rgyArQ0CcywUBzGryOyKFGmaB1HB5Iu2A5/RnSWH1/NEC70AcLtq65Zlaky9
	DsIHVu0ZtI0N897wYYM567NhHiAlibfyhS3WT1EKmu0S553Y6DefJhn0KdX6n+fNe22zQDPqL/9
	U2ngpau+/FfbVkYpcKyNlV7R2cDARaDMclve3GqPRt+5DznLEngdbUJEytZaxHXMiYn3U5yWTiv
	11GkQ4vQj8ga94Jd8FVmDc8eSKcZ7Y1qgI7mnggIrfgT6qpeif9Tfciezj6bRsKw67D6Fy5gKjQ
	fu/kz5mvnbjLpLvz3LkQPAEy9aCJZlGKea/nUQCX9hIS12UG2ARJd/MPKZCcZRuf57ljzcdIeBb
	EZeyH6jesUCs0V3zgQr2XvYnycUl/lJYhRnjcOI6DDjocIg7KkbNDWfiW62knDI+ybpxfla8fVx
	FjGIY10LYMaqZPX/vd6/Z1vVlErspibUNOS+C5vWsKXp9GGQIgUr6DSF5yqT5tuqSielai97cHB
	EO4mE3BL0hqrLt7sZB8DM2s7yXPee/e4sv5h4ZRvH19r84xvJaRBtKReueqfWNWr2HRduta34TB
	GfOFBRqX2fU4q+5O206+OjC8q0JA2IM8Ige0NcqK6z7JE2fqNgIptpUrasA9pFg=
X-Received: by 2002:a7b:ca5a:0:b0:49f:fbad:29ae with SMTP id 5b1f17b1804b1-4a01eb19ffdmr17039525e9.17.1790829736713;
        Wed, 30 Sep 2026 21:42:16 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-095-117-056-101.95.117.pool.telefonica.de. [95.117.56.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f6c5059sm32619515e9.0.2026.09.30.21.42.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 21:42:16 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH 0/2] mm: preserve nolock context through memcg cleanup
Date: Thu,  1 Oct 2026 06:40:54 +0200
Message-Id: <20261001044056.75079-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The no-lock allocation and free APIs can still enter regular locking
through two memcg cleanup paths.

Patch 1 handles rollback after a post-allocation charge failure. If
kmalloc_nolock() obtains an object but its memcg charge fails,
memcg_slab_post_alloc_hook() frees the object through the regular SLUB
path. Preserve the selected allocation mode by using kfree_nolock()
when the allocation flags disallow spinning.

Patch 2 handles the final reference to a killed object cgroup.
kfree_nolock() and free_pages_nolock() can drop that reference in the
caller's context, after which obj_cgroup_release() takes regular locks.
Queue the objcg on a lockless list and finish its teardown from normal
irq_work. On PREEMPT_RT that work runs in irq_workd task context.

These paths were found while discussing the following RFC and during
the subsequent investigation of no-lock allocation and free paths:

https://lore.kernel.org/r/20260919171443.90512-1-kmehltretter@gmail.com

Based on 40288c9206c17. Each patch's forced cleanup test passed on
x86-64 release and lockdep PREEMPT_RT QEMU, arm64 and ARM32 SMP QEMU,
and Pi 400 hardware. The objcg test accounted for all 256 queued and
deferred releases. The series also passed non-RT builds and arena tests.

Karl Mehltretter (2):
  mm/slub: preserve no-lock freeing after memcg charge failure
  mm/memcontrol: defer final objcg release from no-lock frees

 include/linux/memcontrol.h |  1 +
 mm/memcontrol.c            | 29 ++++++++++++++++++++++++++---
 mm/slub.c                  |  5 ++++-
 3 files changed, 31 insertions(+), 4 deletions(-)


base-commit: 40288c9206c17eb66a603262e06a58d300d0f279
-- 
2.53.0
