Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D44156669
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 Nov 2024 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098280; cv=none; b=d73bId7mp8W5Ezgip99iBX0C6c4ys6aDNeZersNxkGKIdoPief6FXjJ6zkZWTAp+FNLykAS2Ugbk1rZTzFNh96Yehtk4Rk6W/EpnQN8kujyX8fncgKpS1dhk6CImMXTD4fC66Xmb2z/+ePCa96XoHgQI6tGgNB3tvp5utDFTeX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098280; c=relaxed/simple;
	bh=o/D2B5pcBs3jgrtGoerHxuWzyxNyqaDoSKTsq0e0wLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-type; b=OjRlwMUMxNm0CGtmM4o2PLPyZNyBArP35n/QM5tthGYingBbG53V2CsHK2OcJynGlBgPwYjIUSll1wZ4YjEgREFvkNwCzDzyyzoRTLsMVUuMZVoUORsyqJM/zzvx9Ic0k6BxyHXo4IvIS+VxKpFTYGCqqUNWhkpHYr7Wm5gKkHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PB1i1l4z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PB1i1l4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732098277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p/iBJks2mitS8xx8UW4h8YzqskEGlCYT8cc+MxErLho=;
	b=PB1i1l4zS4TCkwahP+sOjAjSrkpl7S4z9Pytme5MtWB7e23aYWUmpY/eB9E6aIgqxvkmdK
	3ns1vCIlBIgmOV5dfEVEVx8MPzGk4PJGop9qNIAs0gC9SRo+h55+1R3MZgzVruk3nv5mh+
	eRnftY/LxNiNCqGUN+KJQLoIcTG/aUk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-itwLhw_pPFGv4CKPW0zJiA-1; Wed, 20 Nov 2024 05:24:33 -0500
X-MC-Unique: itwLhw_pPFGv4CKPW0zJiA-1
X-Mimecast-MFC-AGG-ID: itwLhw_pPFGv4CKPW0zJiA
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5cfde99fd17so1416323a12.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 20 Nov 2024 02:24:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732098272; x=1732703072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/iBJks2mitS8xx8UW4h8YzqskEGlCYT8cc+MxErLho=;
        b=fh+rx/V0CuGhiXz5z9Wr6XwusToFZz4J8kjGo1h5VU4pL01WpNqHqyv5E/3cgcYVfq
         p9yAZoAiFWx43gxfkRC6l6UT/dxuHUTA/ECePQu5vvz0jqYBUc3c88JA29o22xbs6T1F
         iy9emTnrC2whKo2wzYBj4L7AsRwDoSU/B4ziEZkM1eAzOw+ZGUFm6EQqbMiyEPjHcN6v
         Q4SgP1ec7h6mdPU88PMZ4yUOvPXykHU6F4grab0SZ+LfEzVwDrW5tVr9PetyFR2bCUVH
         GeE/zxu/m0BtsSKnnwAQH8oaDXJSPHijtx6cSB8R9FseXLsxic6muJm0vkHuKqIcqiAY
         DP+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjUz7uUiGsQX7Wz8NKlwVEqEBIb5/ko3qvfv2LX1mA2Cts4x9uSFfg1dkVSg09F8pDXapdvAdgU2t7deXwXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxM8801sTTGMXJr149FuYUDFrRX8b2izvqkETRP1uoYonkgF/xL
	t73gNXIM6Exncnq0BxAOaYOgC2+2JSQND2r2ogehEIgPs9zoWx76cfD1+fpNWZl7GanflK6Yqnc
	BdTolMgfhBdg3jaZKGdExMukValNthTcz6xkR7XgmmRVcEIXP0zUdvOftn/usGrel
X-Received: by 2002:a05:6402:430b:b0:5cf:e022:24f5 with SMTP id 4fb4d7f45d1cf-5cff4afd5b8mr1390770a12.2.1732098272486;
        Wed, 20 Nov 2024 02:24:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYa8gJ77UzAO3+WSjRuopMOyzPLYeoXq2QJfC/hbjhkfVpAmRLCa3elDekTiUsEaip20iS2Q==
X-Received: by 2002:a05:6402:430b:b0:5cf:e022:24f5 with SMTP id 4fb4d7f45d1cf-5cff4afd5b8mr1390752a12.2.1732098272037;
        Wed, 20 Nov 2024 02:24:32 -0800 (PST)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cff44efb03sm653932a12.29.2024.11.20.02.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 02:24:31 -0800 (PST)
From: Alessandro Carminati <acarmina@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>
Cc: Alessandro Carminati <alessandro.carminati@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH] mm/kmemleak: Fix sleeping function called from invalid context in kmemleak_seq_show
Date: Wed, 20 Nov 2024 10:23:25 +0000
Message-Id: <20241120102325.3538-1-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T060O9vnr1r9rqei68fFxT6P0S4tSGJbOPceBQS-mMI_1732098273
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit

This patch addresses a bug in the RT variant of the kernel where a
"sleeping function called from invalid context" warning may occur in
kmemleak_seq_show under specific conditions:
- CONFIG_PREEMPT_RT=y
- SELinux is the LSM for the system
- `kptr_restrict` is set to 1.
- The kmemleak buffer contains at least one item.

Commit 8c96f1bc6fc49c724c4cdd22d3e99260263b7384 ("mm/kmemleak: turn
kmemleak_lock and object->lock to raw_spinlock_t") introduced a change
where kmemleak_seq_show is executed in atomic context within the RT kernel.
However, the SELinux capability check within this function flow still
relies on regular spinlocks, leading to potential race conditions that
trigger the error when printing the kmemleak backtrace.

To resolve this, the backtrace printing has been moved out of the critical
section.

Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
Please read previous conversation in the RFC
https://lore.kernel.org/all/20241115145410.114376-1-acarmina@redhat.com/

Splash triggering this patch:

```
[  159.247069] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[  159.247193] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 136, name: cat
[  159.247241] preempt_count: 1, expected: 0
[  159.247277] RCU nest depth: 2, expected: 2
[  159.247388] 6 locks held by cat/136:
[  159.247438]  #0: ffff32e64bcbf950 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb8/0xe30
[  159.248835]  #1: ffffafe6aaa9dea0 (scan_mutex){+.+.}-{3:3}, at: kmemleak_seq_start+0x34/0x128
[  159.249053]  #3: ffff32e6546b1cd0 (&object->lock){....}-{2:2}, at: kmemleak_seq_show+0x3c/0x1e0
[  159.249127]  #4: ffffafe6aa8d8560 (rcu_read_lock){....}-{1:2}, at: has_ns_capability_noaudit+0x8/0x1b0
[  159.249205]  #5: ffffafe6aabbc0f8 (notif_lock){+.+.}-{2:2}, at: avc_compute_av+0xc4/0x3d0
[  159.249364] irq event stamp: 136660
[  159.249407] hardirqs last  enabled at (136659): [<ffffafe6a80fd7a0>] _raw_spin_unlock_irqrestore+0xa8/0xd8
[  159.249465] hardirqs last disabled at (136660): [<ffffafe6a80fd85c>] _raw_spin_lock_irqsave+0x8c/0xb0
[  159.249518] softirqs last  enabled at (0): [<ffffafe6a5d50b28>] copy_process+0x11d8/0x3df8
[  159.249571] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  159.249970] Preemption disabled at:
[  159.249988] [<ffffafe6a6598a4c>] kmemleak_seq_show+0x3c/0x1e0
[  159.250609] CPU: 1 UID: 0 PID: 136 Comm: cat Tainted: G            E      6.11.0-rt7+ #34
[  159.250797] Tainted: [E]=UNSIGNED_MODULE
[  159.250822] Hardware name: linux,dummy-virt (DT)
[  159.251050] Call trace:
[  159.251079]  dump_backtrace+0xa0/0x128
[  159.251132]  show_stack+0x1c/0x30
[  159.251156]  dump_stack_lvl+0xe8/0x198
[  159.251180]  dump_stack+0x18/0x20
[  159.251227]  rt_spin_lock+0x8c/0x1a8
[  159.251273]  avc_perm_nonode+0xa0/0x150
[  159.251316]  cred_has_capability.isra.0+0x118/0x218
[  159.251340]  selinux_capable+0x50/0x80
[  159.251363]  security_capable+0x7c/0xd0
[  159.251388]  has_ns_capability_noaudit+0x94/0x1b0
[  159.251412]  has_capability_noaudit+0x20/0x30
[  159.251437]  restricted_pointer+0x21c/0x4b0
[  159.251461]  pointer+0x298/0x760
[  159.251482]  vsnprintf+0x330/0xf70
[  159.251504]  seq_printf+0x178/0x218
[  159.251526]  print_unreferenced+0x1a4/0x2d0
[  159.251551]  kmemleak_seq_show+0xd0/0x1e0
[  159.251576]  seq_read_iter+0x354/0xe30
[  159.251599]  seq_read+0x250/0x378
[  159.251622]  full_proxy_read+0xd8/0x148
[  159.251649]  vfs_read+0x190/0x918
[  159.251672]  ksys_read+0xf0/0x1e0
[  159.251693]  __arm64_sys_read+0x70/0xa8
[  159.251716]  invoke_syscall.constprop.0+0xd4/0x1d8
[  159.251767]  el0_svc+0x50/0x158
[  159.251813]  el0t_64_sync+0x17c/0x180
```
 mm/kmemleak.c | 46 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 0400f5e8ac60..c77899af3e9e 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -356,14 +356,9 @@ static bool unreferenced_object(struct kmemleak_object *object)
  * Printing of the unreferenced objects information to the seq file. The
  * print_unreferenced function must be called with the object->lock held.
  */
-static void print_unreferenced(struct seq_file *seq,
+static depot_stack_handle_t print_unreferenced(struct seq_file *seq,
 			       struct kmemleak_object *object)
 {
-	int i;
-	unsigned long *entries;
-	unsigned int nr_entries;
-
-	nr_entries = stack_depot_fetch(object->trace_handle, &entries);
 	warn_or_seq_printf(seq, "unreferenced object 0x%08lx (size %zu):\n",
 			  object->pointer, object->size);
 	warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu\n",
@@ -371,6 +366,23 @@ static void print_unreferenced(struct seq_file *seq,
 	hex_dump_object(seq, object);
 	warn_or_seq_printf(seq, "  backtrace (crc %x):\n", object->checksum);
 
+	return object->trace_handle;
+}
+
+/*
+ * Prints stack traces of unreferenced objects outside of the lock context.
+ * This avoids potential issues with printing pointers that might require
+ * additional locking.
+ */
+static void print_stack_trace(struct seq_file *seq,
+			      depot_stack_handle_t h)
+{
+	int i;
+	unsigned long *entries;
+	unsigned int nr_entries;
+
+	nr_entries = stack_depot_fetch(h, &entries);
+
 	for (i = 0; i < nr_entries; i++) {
 		void *ptr = (void *)entries[i];
 		warn_or_seq_printf(seq, "    [<%pK>] %pS\n", ptr, ptr);
@@ -1621,7 +1633,9 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
  */
 static void kmemleak_scan(void)
 {
+	depot_stack_handle_t stackdepot_handle;
 	struct kmemleak_object *object;
+	bool do_print = false;
 	struct zone *zone;
 	int __maybe_unused i;
 	int new_leaks = 0;
@@ -1783,12 +1797,17 @@ static void kmemleak_scan(void)
 		    !(object->flags & OBJECT_REPORTED)) {
 			object->flags |= OBJECT_REPORTED;
 
-			if (kmemleak_verbose)
-				print_unreferenced(NULL, object);
+			if (kmemleak_verbose) {
+				stackdepot_handle = print_unreferenced(NULL, object);
+				do_print = true;
+			}
 
 			new_leaks++;
 		}
 		raw_spin_unlock_irq(&object->lock);
+		if (kmemleak_verbose && do_print)
+			print_stack_trace(NULL, stackdepot_handle);
+
 	}
 	rcu_read_unlock();
 
@@ -1937,13 +1956,20 @@ static void kmemleak_seq_stop(struct seq_file *seq, void *v)
  */
 static int kmemleak_seq_show(struct seq_file *seq, void *v)
 {
+	depot_stack_handle_t stackdepot_handle;
 	struct kmemleak_object *object = v;
+	bool do_print = false;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&object->lock, flags);
-	if ((object->flags & OBJECT_REPORTED) && unreferenced_object(object))
-		print_unreferenced(seq, object);
+	if ((object->flags & OBJECT_REPORTED) && unreferenced_object(object)) {
+		stackdepot_handle = print_unreferenced(seq, object);
+		do_print = true;
+	}
 	raw_spin_unlock_irqrestore(&object->lock, flags);
+	if (do_print)
+		print_stack_trace(seq, stackdepot_handle);
+
 	return 0;
 }
 
-- 
2.34.1

