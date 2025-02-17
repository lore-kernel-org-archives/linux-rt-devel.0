Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2729D81E
	for <linux-rt-devel@lists.linux.dev>; Mon, 17 Feb 2025 04:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739766086; cv=none; b=bCpqtA/Bhv6FJ3mIrI6uzq4PQMc3gnLOXLNfQvvISx0zX3YqRzZ/5y+97vSBscSOXxfAsG+zINNmNpL9GBobv1Z3tQnamGeeZ8xCubvchcSpyySph9ipE9jKuVuREVLeEs3Po3+c7OW6cwOXEcvBFyXeESyaobSjVLiUFcj+4UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739766086; c=relaxed/simple;
	bh=4tTD/9udTsFgVqnjNZj5Xj+O8pdGUCNNAD0cmckPo8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dat1/fvwLkEJTjw3dqGb9chaXA/QAthMNaXgeXaHB37eUq+le7FB4pGAKKE+rOiJ/fTiVZvkKHxOMiWgl8g/N9sTJ0vvvvN3w+ya/6ncSgbHfbp3Bga/ItV4BFRR2sGh7IrOaZuwN642BLvrspQH7qWpFhH0yMehrbF+hIwQOPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G3ycG40Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3ycG40Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739766083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YqbMpBl1Nw5n1bOPGE94JMKO6OVu4WYCnIOo4Qkr9yc=;
	b=G3ycG40QvhvCDpAwW3F7yc+pEcJjcTIfZjLcaFtFWXTSC18q9AmfBcq72SzEHySJjqQgdz
	1TbKkWlNejVh+ls3sKhNGYi+jefIKcGnoZWCswbkCXP53IyzXO8zbEVAg78K2K/uuWmNyB
	34bIEjZTt93AguzbJaoFVh3wAkDZOaE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-72Bo0qNkMOOtvPEmGFO3cg-1; Sun,
 16 Feb 2025 23:21:21 -0500
X-MC-Unique: 72Bo0qNkMOOtvPEmGFO3cg-1
X-Mimecast-MFC-AGG-ID: 72Bo0qNkMOOtvPEmGFO3cg_1739766080
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2541D1800875;
	Mon, 17 Feb 2025 04:21:19 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.83])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 31E31300018D;
	Mon, 17 Feb 2025 04:21:15 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Nico Pache <npache@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v3] kasan: Don't call find_vm_area() in RT kernel
Date: Sun, 16 Feb 2025 23:21:08 -0500
Message-ID: <20250217042108.185932-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The following bug report appeared with a test run in a RT debug kernel.

[ 3359.353842] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[ 3359.353848] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 140605, name: kunit_try_catch
[ 3359.353853] preempt_count: 1, expected: 0
  :
[ 3359.353933] Call trace:
  :
[ 3359.353955]  rt_spin_lock+0x70/0x140
[ 3359.353959]  find_vmap_area+0x84/0x168
[ 3359.353963]  find_vm_area+0x1c/0x50
[ 3359.353966]  print_address_description.constprop.0+0x2a0/0x320
[ 3359.353972]  print_report+0x108/0x1f8
[ 3359.353976]  kasan_report+0x90/0xc8
[ 3359.353980]  __asan_load1+0x60/0x70

Commit e30a0361b851 ("kasan: make report_lock a raw spinlock")
changes report_lock to a raw_spinlock_t to avoid a similar RT problem.
The print_address_description() function is called with report_lock
acquired and interrupt disabled.  However, the find_vm_area() function
still needs to acquire a spinlock_t which becomes a sleeping lock in
the RT kernel. IOW, we can't call find_vm_area() in a RT kernel and
changing report_lock to a raw_spinlock_t is not enough to completely
solve this RT kernel problem.

Fix this bug report by skipping the find_vm_area() call in this case
and just print out the address as is.

For !RT kernel, follow the example set in commit 0cce06ba859a
("debugobjects,locking: Annotate debug_object_fill_pool() wait type
violation") and use DEFINE_WAIT_OVERRIDE_MAP() to avoid a spinlock_t
inside raw_spinlock_t warning.

Fixes: e30a0361b851 ("kasan: make report_lock a raw spinlock")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/kasan/report.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

 [v3] Rename helper to print_vmalloc_info_set_page.

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 3fe77a360f1c..7c8c2e173aa4 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -370,6 +370,34 @@ static inline bool init_task_stack_addr(const void *addr)
 			sizeof(init_thread_union.stack));
 }
 
+/*
+ * RT kernel cannot call find_vm_area() in atomic context. For !RT kernel,
+ * prevent spinlock_t inside raw_spinlock_t warning by raising wait-type
+ * to WAIT_SLEEP.
+ */
+static inline void print_vmalloc_info_set_page(void *addr, struct page **ppage)
+{
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
+		struct vm_struct *va;
+
+		lock_map_acquire_try(&vmalloc_map);
+		va = find_vm_area(addr);
+		if (va) {
+			pr_err("The buggy address belongs to the virtual mapping at\n"
+			       " [%px, %px) created by:\n"
+			       " %pS\n",
+			       va->addr, va->addr + va->size, va->caller);
+			pr_err("\n");
+
+			*ppage = vmalloc_to_page(addr);
+		}
+		lock_map_release(&vmalloc_map);
+		return;
+	}
+	pr_err("The buggy address %px belongs to a vmalloc virtual mapping\n", addr);
+}
+
 static void print_address_description(void *addr, u8 tag,
 				      struct kasan_report_info *info)
 {
@@ -398,19 +426,8 @@ static void print_address_description(void *addr, u8 tag,
 		pr_err("\n");
 	}
 
-	if (is_vmalloc_addr(addr)) {
-		struct vm_struct *va = find_vm_area(addr);
-
-		if (va) {
-			pr_err("The buggy address belongs to the virtual mapping at\n"
-			       " [%px, %px) created by:\n"
-			       " %pS\n",
-			       va->addr, va->addr + va->size, va->caller);
-			pr_err("\n");
-
-			page = vmalloc_to_page(addr);
-		}
-	}
+	if (is_vmalloc_addr(addr))
+		print_vmalloc_info_set_page(addr, &page);
 
 	if (page) {
 		pr_err("The buggy address belongs to the physical page:\n");
-- 
2.48.1

