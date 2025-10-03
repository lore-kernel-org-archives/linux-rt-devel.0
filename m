Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D208B2848AC
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Oct 2025 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759491984; cv=none; b=TsSPxhdcYz3kfPYjAj6slcTS6TxQreFHbykO5a5k/e2SJgHgdibWAK4wBkUF/e+4itI8ihWwS0ADlnfyEHkD91a4traN/6+KF5awSPJgmQ7+/ic3IX+L+HGbpviYiw578/iCY5sHk0Ru9Zvo1ogm1ktE7XJ5+NdCQFK69DibsG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759491984; c=relaxed/simple;
	bh=PqpCO1hZ5AzWg8lpqzlwYEmvVQBm7UKwvlNkj9beh4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iC9j+xvkgRlk9QVk9eUd8/9npUjf+NEWUQvWOJVNVsY47rvR4w4qHB+BnWCnwsgE+hamIL9niLNN9JpVx9EFn3IiKFntTdLly9ToMbEkg54nG3DumTct00Ji9EOaYSsIJngMQWSGsErWILzvOwe0ajJCHTgBAfm9k5mS79Lu29g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9rapT5x; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9rapT5x"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3369dcfef12so2655071a91.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 03 Oct 2025 04:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759491982; x=1760096782; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kr5m4Q2MhDO3zmxeDrZVa1hCLYfkmOsaOLffDymj6ak=;
        b=L9rapT5x1StoI0f5eiRprwiqk6O5FWVCTQ8oHAVfbty+t1aB9/UUKVlptz49l7jRgV
         fEmpK6MmC63a/c4ronQLlywQ5lH1I3LygbW6UtkVefYJn7gLWqBJlma2iLywAqo+dOr9
         5u799ma9xjfGcFOgKYQOUKbusESOZ5mF7z8xJXNsyxMjGNNV7rZIyM6PgsMgLT3+Jm0+
         lxg9jXKL9thfiHA9qJdR2+0Zy5Kds/Zq5I0PYK1WLysAuSpw0rHuxSEdAXQX0MLS+tu2
         mYtNkKD/0KRRMJDp/c4B0fyvBFdJIHMfsiQCzuL+w5VJDl04Bd+zIkRHjHCGqvy/WP7G
         0u8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759491982; x=1760096782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kr5m4Q2MhDO3zmxeDrZVa1hCLYfkmOsaOLffDymj6ak=;
        b=HEhtXNbvw/p2491iNkUO4J5KC5T04oxqSBeq/n3aa7/2RVEQkb7c6eosEU3OnLWIs+
         ef1HAEKf/qPfBySTcTbm79RBKoNbSVUznvzZC7TLEIuuIKlTJUQcVq1IF+z6/jFG+KNJ
         G7mrPG8vdeS4AONTULzwXr5cXvv4M5hGSsdgCxkuTb1SgFaRlb2zwAym3Dyv+BTCYU2p
         s4eRrPzZgXV5hedC7w5Yxx6XFITh1lHJ3EGgLjQYsdyiV9kcb4kGATDyAF+H/CX19j7G
         VThqr3w4liIRP532J+xXF39cZM/WBKl1SELi0/GGywxOxNLTYavgrtfhqrfUUjfXG0Jc
         unqw==
X-Forwarded-Encrypted: i=1; AJvYcCXpG7t6N44tv0lO775BaS7PgAzmZpeuu3Ua9H6p0dJsLXf6PIidZ2kyPR0I5FTc98tHE+qi+ytAlBElkVLHiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBeTYcFzM7/vANFjlGwTfH6m4LdsARKB5wW9Lm4ZADzXLJnI7Y
	NnIvVs1V05kEvmY3uKEitImzjkj7eaIXVQnH9wHr4zS4xK4jrFt06isU
X-Gm-Gg: ASbGnctHZkl6K+QgCc33pTiIplmLygdYt9wwQHXziNn9Z6MnpFZ7CTYlKvoI03UKMn6
	ZN1NT042WaxRjwicekliCWzczT+Lv8NScxH9nUZJDVIbQtL1juR9YvPdG23yRO1VKjKFtF8sRrq
	QFlYnKvmcTreu8LraUTIxg+LnZ6T1cQOVjumJk/resIxglrsknNd1P7jOuHIe6CoA44aJmzXHis
	n88aXFZQ+xJqxq+o7kEruedqVoVl2rv72kX70txvaa+z5jUSJBQBxCBP6I9W43BMrtmPYKIytOd
	IczjQlIzLFXF/zbVN2tCJL5uySjldiSmi8pEsNn1tehw/IsrF9SdvOLgQnpNi4Mm3Yg2RWyW4R2
	3VCM38/Nu8TH12CjGY1MYanTbMZfkEVZKAU77wZjWSA==
X-Google-Smtp-Source: AGHT+IE+B+A6PY10FHNa/K7kwAlpZK7Yj3hJ8GaSS7FT2H3r5Hjjq9oeSORJAi5t9tZGsLPWJ2J+ng==
X-Received: by 2002:a17:90b:4a50:b0:32e:38b0:15f4 with SMTP id 98e67ed59e1d1-339c2724834mr2844413a91.7.1759491982024;
        Fri, 03 Oct 2025 04:46:22 -0700 (PDT)
Received: from fedora ([119.161.98.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm7825727a91.23.2025.10.03.04.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 04:46:20 -0700 (PDT)
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tiffany Yang <ynaffit@google.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Nirbhay Sharma <nirbhay.lkd@gmail.com>
Subject: [PATCH] cgroup: Fix seqcount lockdep assertion in cgroup freezer
Date: Fri,  3 Oct 2025 17:15:55 +0530
Message-ID: <20251003114555.413804-1-nirbhay.lkd@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
introduced a seqcount to track freeze timing but initialized it as a
plain seqcount_t using seqcount_init().

However, the write-side critical section in cgroup_do_freeze() holds
the css_set_lock spinlock while calling write_seqcount_begin(). On
PREEMPT_RT kernels, spinlocks do not disable preemption, causing the
lockdep assertion for a plain seqcount_t, which checks for preemption
being disabled, to fail.

This triggers the following warning:
  WARNING: CPU: 0 PID: 9692 at include/linux/seqlock.h:221

Fix this by changing the type to seqcount_spinlock_t and initializing
it with seqcount_spinlock_init() to associate css_set_lock with the
seqcount. This allows lockdep to correctly validate that the spinlock
is held during write operations, resolving the assertion failure on all
kernel configurations.

Reported-by: syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=27a2519eb4dad86d0156
Fixes: afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
---
 include/linux/cgroup-defs.h | 2 +-
 kernel/cgroup/cgroup.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 539c64eeef38..933c4487a846 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -435,7 +435,7 @@ struct cgroup_freezer_state {
 	int nr_frozen_tasks;
 
 	/* Freeze time data consistency protection */
-	seqcount_t freeze_seq;
+	seqcount_spinlock_t freeze_seq;
 
 	/*
 	 * Most recent time the cgroup was requested to freeze.
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ab096b884bbc..fe175326b155 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5789,7 +5789,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	 * if the parent has to be frozen, the child has too.
 	 */
 	cgrp->freezer.e_freeze = parent->freezer.e_freeze;
-	seqcount_init(&cgrp->freezer.freeze_seq);
+	seqcount_spinlock_init(&cgrp->freezer.freeze_seq, &css_set_lock);
 	if (cgrp->freezer.e_freeze) {
 		/*
 		 * Set the CGRP_FREEZE flag, so when a process will be
-- 
2.51.0

