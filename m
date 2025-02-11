Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0910325A351
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Feb 2025 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290120; cv=none; b=pcFLmYs81c0kUTwRIOy5d4lc1TBHy7juzk09dUSR192BOYI3SQAvbb3YVGkV0j1nXA1fM+mCx8P1qstf+BeoWzjzK02qJ5A39d9x+2Jh2IPLOUP/A1QyX7Qshq4ae/AA1pngYjTL9n/gydAl3b+wM1q3SR/oya5vR+LE1n9qEII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290120; c=relaxed/simple;
	bh=ml0xQgdCLasCwsDWWoirjYy2G9OXDcBgWmJPS+yMwFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oWTyvZQUo448o9iNzNoOC0s66FcWkiDjAZmYw3AVR1TvAcfMvSu4cFFJfuUXfMU9sEyRUnxRgI7WhxitlVkZYmxNvCEFFXBuxv3tf28Td6tdZsp9v4J3GZq7kIMVN4SpjSWpuk19L6isK9o2lmvDnrPP5siOxhtLGCnpEJl++Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IcbUnDuK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IcbUnDuK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739290117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UipiODYFsFgVF8vxMUdu6AW5VgLIbfrFFLlK7TYmKsA=;
	b=IcbUnDuKllOC+T2HfO4W+oR13mBn44xAeXP/M0Dn2SPjEDZI8B9LvZRSfJknr61HxoHSJg
	NswXQXwsMKe72LtRkUnXUDGYcJFyxUDRHmY56aXdlsBSrrgYUuxNPQ8Icb7IkOfMkzaEZP
	FopnDFKSThHCxsvKbFwdntx6nW9+gnc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-o45N5vneMBKaSqLBsS2KlA-1; Tue,
 11 Feb 2025 11:08:33 -0500
X-MC-Unique: o45N5vneMBKaSqLBsS2KlA-1
X-Mimecast-MFC-AGG-ID: o45N5vneMBKaSqLBsS2KlA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F35C19560A5;
	Tue, 11 Feb 2025 16:08:31 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.207])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8964A19560A3;
	Tue, 11 Feb 2025 16:08:27 +0000 (UTC)
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
Subject: [PATCH] kasan: Don't call find_vm_area() in RT kernel
Date: Tue, 11 Feb 2025 11:07:50 -0500
Message-ID: <20250211160750.1301353-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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

The print_address_description() is run with a raw_spinlock_t acquired
and interrupt disabled. The find_vm_area() function needs to acquire
a spinlock_t which becomes a sleeping lock in the RT kernel. IOW,
we can't call find_vm_area() in a RT kernel. Fix this bug report
by skipping the find_vm_area() call in this case and just print out
the address as is.

For !RT kernel, follow the example set in commit 0cce06ba859a
("debugobjects,locking: Annotate debug_object_fill_pool() wait type
violation") and use DEFINE_WAIT_OVERRIDE_MAP() to avoid a spinlock_t
inside raw_spinlock_t warning.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/kasan/report.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 3fe77a360f1c..e1ee687966aa 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -398,9 +398,20 @@ static void print_address_description(void *addr, u8 tag,
 		pr_err("\n");
 	}
 
-	if (is_vmalloc_addr(addr)) {
-		struct vm_struct *va = find_vm_area(addr);
+	if (!is_vmalloc_addr(addr))
+		goto print_page;
 
+	/*
+	 * RT kernel cannot call find_vm_area() in atomic context.
+	 * For !RT kernel, prevent spinlock_t inside raw_spinlock_t warning
+	 * by raising wait-type to WAIT_SLEEP.
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
+		struct vm_struct *va;
+
+		lock_map_acquire_try(&vmalloc_map);
+		va = find_vm_area(addr);
 		if (va) {
 			pr_err("The buggy address belongs to the virtual mapping at\n"
 			       " [%px, %px) created by:\n"
@@ -410,8 +421,13 @@ static void print_address_description(void *addr, u8 tag,
 
 			page = vmalloc_to_page(addr);
 		}
+		lock_map_release(&vmalloc_map);
+	} else {
+		pr_err("The buggy address %px belongs to a vmalloc virtual mapping\n",
+			addr);
 	}
 
+print_page:
 	if (page) {
 		pr_err("The buggy address belongs to the physical page:\n");
 		dump_page(page, "kasan: bad access detected");
-- 
2.48.1

