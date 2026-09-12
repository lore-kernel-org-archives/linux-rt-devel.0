Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E093921EC
	for <linux-rt-devel@lists.linux.dev>; Sat, 12 Sep 2026 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242963; cv=none; b=LmIP7T73T/XA4lafr7KV4owZ/1+1QL9EF2U1eHqi+16uyXiex7CtcdPorm+xqOCKapLXziSPxZ9Obwoiy1YX+RUzs0R7vDDrxMLBlDhRTtVbf3R22iQ1VhqQLcJrWeWjOniL7Cs2zTsSFOT0I9PDmt2ES557S+KOpQxgnhctX7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242963; c=relaxed/simple;
	bh=ydcLswhKfW/cDtNkOWt8BaQY/wFqG2LFzkg1wf5qWnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZxI17iqSjy9mjF1AdctUznEYBFKvdYZM0YmT/Gn6qHiKWJ9c2zKPVm2vi3+HM/safxOYRboBB75IK8F2HzIyzjgq3XcjOKe5tZldqihJVctK7D7cmWdyruue/J7xeA/jxZ5IckDUAztKNqgjdw/oZoeAhOmiQY5ue8e4+hIXxFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIMHgFle; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIMHgFle"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccff31419so5785255e9.3
        for <linux-rt-devel@lists.linux.dev>; Sat, 12 Sep 2026 12:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789242959; x=1789847759; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YxuvUQU/wvk/5tAU7GY5bOYjzHhQjt27KLZg5QIEMsc=;
        b=NIMHgFleWBsVKqGbbvhl6L569EhhM6YfFAzoMLBGaIu3aEbcaGa6P8m8WgDfjrENCY
         rGZSvMolQ30WVOhy/eqIXYC/46kYGv95U700YKe5ZHb54A9JBxqtw+qBbcjn9nU/FCiz
         pQ0cw4qyi/UxYtsS94G6icmsqlLaAwllEjqRNqwvWWJaO6x7e5KDHAnLK+tJneCMRRWU
         suWOJ93ov7pDqmq5i9lz0YlJGbloR2TmWOMuUAoOuZrsCxRXw3mZmHhmApTaMNC3nLn7
         EHQs3daSd4BBavtUqU35yTxLP1a5C4GAFsSG6kDYs9KSHIKyNxnWb6dbiZBmvDoGSVcQ
         Vpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789242959; x=1789847759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YxuvUQU/wvk/5tAU7GY5bOYjzHhQjt27KLZg5QIEMsc=;
        b=Faq+3x1+CGuKo7HYx5IKJ/PqwG29K/etLXgcYZOfhQUZS0aJQq24/c/l8qMcExHZ04
         cSuWTNO5X1rh5J1VwSikLlBW1LQXWPumOwNB6AoVxJIyOzvrufNC8MQDprwOOPkxxEM1
         vh5exzJScqtkapuTZUKT6k1kAmZoxVRR3yFWzL4ZCkAH7v1X2fVQfZwOx6GtSgxoOt5c
         A9JHAdtP6zoPMpcKIKjjpNDYHqyhNJYGZzSNeivYJBUxbts+3afYWPpPfDkrsG6wBvOa
         /HDMQFj3Fqd6Sb5JzfYR3L0WOScfrB6VvgxKlM+XFfJmO9hQ8Fjr4F0oYfLFvCpg0K6P
         XVEg==
X-Forwarded-Encrypted: i=1; AKwUvBzHKxHl9+jPyZuZkkmZigxRp6XN9ATAzr8eEg+B8PX/hv66YBJ2+IfxODqzHMkn+5451nX1blLRTxhgRK/icQ==@lists.linux.dev
X-Gm-Message-State: AFuF++n9knseENIRVfcATm61diKd4Fdz494Wp1psUp7zR32OnvcSZGhW
	qaMkFyX15/QEH9euD1qDlZXFOPxA3mT2LuPBk/eXOwMeUkxyrTmlJHSF
X-Gm-Gg: AYBFou0yK25qb2qr/yLGsm6IqFillJzfzUrHDfUmeJj6giy1ErS7gnlzyQiRUAaG2dy
	OYRIvV/LOLIpxeKiv73aR7Q+dMYWsfDl7H/tQVbYfA534EmYjXteE5JcMq/AEuPwNWgkOAGxjE4
	D7HUcf65BxiSSxCo6afD9YxDOCaLusJ9WaHLEgSXu4XL/jHVjamTWHQp059R2dM54I3O4GpsUcl
	F5KlGNotLZCPs9v1xzHiN05eQ7z1woQiJ9dsPY05R4gTCy/EKtUlPLkxSsbfbHaXgoJgUVQTH8y
	dSq+sGMMY+kMpLhTGdzVDdE3SMVdHSnsNtBpRjJ65Y/tspa16wh6RhQvwxSPYTVyP4Zsj+m55Ei
	XbGXIvaWnnSCLou28jG64TKFzsUO5LOKRoU/+s4NYLHyiJtE/orMTpLeNeP9uOJ9HzXKhd+XmqH
	DOm4k5LORyTxXhOwaSJFJJ4OOcxgecZ8NosK5vJg+3bNZCCtp5WGwBkF2VjRF1TaR6CU8McIId5
	zYFO3L/4h49mC0HEfA8dGAx55wxMXRxsSfU6Ld7iQGp6bFS9z9z60k6q/kVFlDJzSDPJRy593iW
	/WeKs/HL1oqtKxk220zdpHNNOwgt54qtNNPJ69EIu6mUNkhPyMj7Pifd4G3gN9YU+SgdY7oliYm
	SXsHKzZXWxADZ+/7YNg==
X-Received: by 2002:a05:600c:5249:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-49e6caa782cmr34402295e9.5.1789242958359;
        Sat, 12 Sep 2026 12:55:58 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60adaee4sm267089045e9.14.2026.09.12.12.55.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 12:55:58 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Linus Walleij <linusw@kernel.org>,
	Radu Rendec <rrendec@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/4] ARM: allocate the cacheinfo early to fix the PREEMPT_RT boot warning
Date: Sat, 12 Sep 2026 21:55:48 +0200
Message-Id: <20260912195552.76673-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series moves ARM cacheinfo allocation to the boot CPU to avoid
sleeping-lock warnings during PREEMPT_RT secondary-CPU startup. It is
based on 5225b8eec4c9 (7.3-rc2 plus one day).

Patches 1-3 prepare for early allocation: bound cache-leaf writes,
include external caches in the allocation size, and guard CLIDR reads
on older CPUs. Patch 4 enables early allocation. Please take all four
patches together for stable.

Tested on QEMU virt (Cortex-A15), vexpress-a9 (Cortex-A9 with PL310),
and realview-eb-mpcore (ARM11 MPCore) with PREEMPT_RT, plus non-RT
virt and vexpress-a9 builds. Cache sysfs output is unchanged for the
normal platform DTs, and CPU hotplug passes where supported. Additional
checks cover DT leaf undercounting with KASAN and ARM11 DT cache
descriptions.

The full series also passes on a Raspberry Pi 400 with a 32-bit
PREEMPT_RT 7.2.6-rc1 kernel: the boot warning is absent and all 12 cache
sysfs entries match the baseline. CPU hotplug is unavailable there.

The series applies unchanged to 7.2.6-rc1 and v6.18.

Karl Mehltretter (4):
  ARM: cacheinfo: avoid out-of-bounds write in populate_cache_leaves()
  ARM: cacheinfo: count external caches in early_cache_level()
  ARM: cacheinfo: guard the CLIDR read in populate_cache_leaves()
  ARM: topology: allocate the cacheinfo early on the boot CPU

 arch/arm/kernel/cacheinfo.c | 49 +++++++++++++++++++------------------
 arch/arm/kernel/topology.c  | 13 ++++++++++
 2 files changed, 38 insertions(+), 24 deletions(-)

-- 
2.53.0

