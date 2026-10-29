Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269903;
	b=yYN5uYeZyUqrkaG/OpqO6FzTuy1Yy9Lpzp1eb1mWKHaUnA1PJDn5ew8VuqKbQaPCIIY4
	 J82Ng6xY+KF3yKRJqRNIkvM7RA4ZJbxv4kvvR9tn5/warI75akehwu1YM25L+KlFCiDeq
	 u9kda74ekr9wnbScjPUzk0hgaZNIc/fvlFKnvX/GV3QsiwSlLk+AyKJrLASDIHLWl0yKD
	 Zgg21XyROC+in+4r1tbRs4odYPcJ4jGpH2TTERuOvAtym44gNsOfU8KHZ7w+MhPQNBNvD
	 vmfMox7qKCqI2KUOsiT2YVZQNLs/J6YQT0TBeK8a5YziWYy2Xx9YroYOi6V2y2bnafA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vuWTuv7wT+CRQwrB4gpB0n/Lvy+IrJTCH55qZNEAo0g=;
	b=D7/yePKBcrX8x3LBEdZC7Jhd6ci2dFHRqP+IWlvkQf9hzKMtrpdCukNpMX7Mexy0grrh
	 Lfv89vg/LArjbE2tCxpe24PZUqZ00PB3A/RqUwCLpyKQSO9edLDCUNy//IEXdJQHHvZG1
	 /z1+uFXofsVd7YX+r3mx3661cIlG8p4lJ1jRw2x7wZ13DoUDXyLoG40aTKpRoAjDFyjr2
	 fd4QdTs97+IVVOwExf3BYzOZOdk74H8RBQLw5nWFKsCD/h4zi+B45mgrFn3WapUstyHa2
	 E7Tc7NRrl4QA7UXfsDwsISOr0ZmYD7+14KJQGzRTPFtJo6EdQUwZF8sN5kPBRB+q7iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GOqjWm+F;
	arc=none smtp.remote-ip=74.125.229.136
Received: from mail-dl2-f8.google.com (mail-dl2-f8.google.com [74.125.229.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55872606A31D
	for <linux-rt-devel@lists.linux.dev>; Thu, 29 Oct 2026 10:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55872606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GOqjWm+F
Received: by mail-dl2-f8.google.com with SMTP id a92af1059eb24-1379d236149so643094c88.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 29 Oct 2026 03:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793269901; x=1793874701; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vuWTuv7wT+CRQwrB4gpB0n/Lvy+IrJTCH55qZNEAo0g=;
        b=GOqjWm+FtAp1l0rOeZ6OuEMMF6mpXypEEQBq6QiV+BTuY9iatcuOur10lMgyghRit1
         Tom1ynO9ZHZGFZwrCtP3X8ftnOYSHidm7j8lISBSX05yGGiCMV2o55jkj+MFLxqw4XyH
         fN85PnMXD16D/a48/NGCFdY7L8yhU9wS7/nTAF2RE7e26hpY8HWTw1yR1I2LUiRX9bLD
         a/7NexXyo15LZrBnN1kWI1AEGmuiY1pHHdDDO9iyn4+2DUDywbq3I2RDLl7pS7fneZ8b
         Uo/xtxdH6/GIT1ZM5VWgBZF6a9ZRXs5bas7WNdK1Qyj8K4yOFX4HK+2oDbm7bKMj/jAr
         1wBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793269901; x=1793874701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vuWTuv7wT+CRQwrB4gpB0n/Lvy+IrJTCH55qZNEAo0g=;
        b=LBO987bt4vsqBYxToC8CfgPUMhf9WEoBxKskCXcdQ8JZqJuLLVc7K5JBt3fFOmzR9W
         zVJU+1/BkFo1DbkGdVLDVpxHb0cxn1aVXy7zi6o2dLseJF1vqpDZP1ji54a9PznM1ISX
         iAldVTI6MqZGmrhu61kGm/B13AW8MbI8n6vprJqJ2Rw41Q6G6fCUc4Pk0RXrFMBa3hSj
         V6PeRA+hbVvEhF1lZwipe1+NuTBVRgXSAStJ1V7bHTD+2u52f1LpV7hFIQlQxxVNDvhY
         khUy4YWVXBP5c9u5BA2VAMQIFiYSL4LfyGkUh25qneLpyfYv4PppcxLH7SGq4Sr3Y4UZ
         aJLQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlDH8PL4Hk2FwcrUnUwvzmxO6GYjMy/EaUZ7cBugpn+DbTuxQ/uh7EUhd5Gp/H7T8/NvCY9vzNol68A0O3tQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLZcRF69CwI+jFUGWPY866AVTZlMugiCffp1fdCjP8peNY1H494
	mBplWAPgf1v6wRCbVuK7Fgb6NMIipi4kUIDsW6i95+PUfIHvG9WQIOQ=
X-Gm-Gg: AYBFou2LOMMBcFe+nvAbCfYWNyJMGBK7EFoMqDWGNqv7V9XJinQsFV94u9PhFeUgp1G
	uAWsRMdXndCI9qyBOVUrWBpdSQbX4hrrM/Iu8SQx000MnAHdD3bALZc7WUnILNM9h0xKg3Gsuvp
	7B8NxW/ymnAuxdjMBSrDoLOccvZycMopDsifofTbEraYZkWnmF3rmCUO/YNiqEaQRvk7kufmMVi
	4sf8W9QgNSfAcxq0zvx6eXuQvPvjnS55aAlMUg/dIyaYenq3pCGUrR1DB/2IldqDSSJ4/hA6iWo
	kptrEjVfSD6F0m1hZYD4xV3teXzCF9rkEi6JOmMDO+PGoyVRdqPTCR+FGEuZ3v/woQ/ORUqt7rd
	WqT1t/osrLH0au7bghHsuG8f3xHMrKLumRpFluF8pqgx0c4ZYsrvipPXall+A70ddn+rgLA788N
	XY0deKl14ITE9V9O/MM4jIBFQclZRdyR+zKeBXBDQIVxqXjs2VKihx4kuHOGRVZijcFi5E/+4tJ
	pj2fAz3/yQ6BshPJbfkfNK4mIW4UY9VpFtkKu3ko35GQFM/Dk9d5vkGBIk0KHV00JJ5m5SBwfpg
	uaiUZwd1nVHZSF++iAzyRwpxWzd+34rOTJEt1AgG
X-Received: by 2002:a05:701b:2818:b0:187:c940:21b9 with SMTP id a92af1059eb24-1a6cd684cd5mr7037612c88.30.1793269901257;
        Thu, 29 Oct 2026 03:31:41 -0700 (PDT)
Received: from archlinux ([2405:201:ac01:5300:9bc6:9c9e:e00f:4eb0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75f143cacsm12888470c88.16.2026.10.29.03.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:31:40 -0700 (PDT)
From: Anvik Loitongbam <permissiontogallop@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Olivier Langlois <olivier@trillion01.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org,
	Anvik Loitongbam <permissiontogallop@gmail.com>
Subject: [PATCH] io_uring/napi: fix list use-after-free on PREEMPT_RT
Date: Thu, 29 Oct 2026 15:52:44 +0530
Message-ID: <20261029102244.141621-1-permissiontogallop@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Commit 45b3941d09d1 ("io_uring/napi: fix io_napi_entry RCU accesses")
converted the NAPI list teardown to list_for_each_entry() and
kfree_rcu(), with a comment claiming that list_for_each_entry_safe()
is not necessary because kfree_rcu() defers the free to the next
quiescent state.

This assumption only holds while the surrounding spinlock section is
non-preemptible. On PREEMPT_RT, spinlock_t is an rtmutex and the task
can be preempted while holding ctx->napi_lock. The raw lock inside
kfree_rcu() only defers the preemption until it is released, and the
release still happens before the iterator advances. Once the task is
switched out, the context switch is an RCU quiescent state, if the
preemption lasts long enough for the batch to be flushed and a grace
period to complete, the callback frees the entry, and the iterator
then reads e->list.next from freed memory. The same pattern exists
in io_napi_free(). I did try to produce a uaf on an rt kernel
build, but it did not work.

All list mutators are serialized by ctx->napi_lock, so the entry after
the current one cannot be freed before its own iteration. Caching it
first with list_for_each_entry_safe() in both loops might be a more
safer and correct approach.

Fixes: 45b3941d09d1 ("io_uring/napi: fix io_napi_entry RCU accesses")
Cc: stable@vger.kernel.org
Signed-off-by: Anvik Loitongbam <permissiontogallop@gmail.com>
---
 io_uring/napi.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/io_uring/napi.c b/io_uring/napi.c
index 7e698720cd51..d299c89cfc3d 100644
--- a/io_uring/napi.c
+++ b/io_uring/napi.c
@@ -110,16 +110,10 @@ static int __io_napi_del_id(struct io_ring_ctx *ctx, unsigned int napi_id)
 
 static void __io_napi_remove_stale(struct io_ring_ctx *ctx)
 {
-	struct io_napi_entry *e;
+	struct io_napi_entry *e, *next;
 
 	guard(spinlock)(&ctx->napi_lock);
-	/*
-	 * list_for_each_entry_safe() is not required as long as:
-	 * 1. list_del_rcu() does not reset the deleted node next pointer
-	 * 2. kfree_rcu() delays the memory freeing until the next quiescent
-	 *    state
-	 */
-	list_for_each_entry(e, &ctx->napi_list, list) {
+	list_for_each_entry_safe(e, next, &ctx->napi_list, list) {
 		if (time_after(jiffies, READ_ONCE(e->timeout))) {
 			list_del_rcu(&e->list);
 			hash_del_rcu(&e->node);
@@ -264,10 +258,10 @@ void io_napi_init(struct io_ring_ctx *ctx)
  */
 void io_napi_free(struct io_ring_ctx *ctx)
 {
-	struct io_napi_entry *e;
+	struct io_napi_entry *e, *next;
 
 	guard(spinlock)(&ctx->napi_lock);
-	list_for_each_entry(e, &ctx->napi_list, list) {
+	list_for_each_entry_safe(e, next, &ctx->napi_list, list) {
 		hash_del_rcu(&e->node);
 		kfree_rcu(e, rcu);
 	}
-- 
2.56.0

