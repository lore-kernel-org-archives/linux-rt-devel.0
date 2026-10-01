Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDF4426D09
	for <linux-rt-devel@lists.linux.dev>; Thu,  1 Oct 2026 04:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829746; cv=none; b=J0TviV61z9SO5r6I8rXxD2ht376I3Jqm0mgbKx3Ho2SJZIyHN2o/8iBlsi2AVGbJTtmIcgWIXS9R0uOZInU6d8y4BMwIHoiAhkhREz00b10zJ5Aq6jD7+OOSXVrZboN7MVnPlICCOLxox/PSiw23WJ+tAZD+TaiU88+ZugdDEiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829746; c=relaxed/simple;
	bh=lR2KR3l1NhxaZrni+JXs85cU0OVhYTgsr4rI2+bzgd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBZdoikCAzGVKmMLUok+SLbJ4RQVqb07Zp+5hBpqCNOY6MWrFCb+ZlR+hpRwuMk8sMdu/qVnvAqppo7STruzuUCZgGnDFSX4dcZ2RgGopCD7bD9edpC6gle3Gg1fqjltTzWz5dQpJ5GNttdljfJhDm+Zu0QenrV48kmlkoad0iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcHX4nLL; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcHX4nLL"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffed768deso15012385e9.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 30 Sep 2026 21:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790829741; x=1791434541; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XIBJllRq9Qoioyf410EUtaPM6Z2WKPJiq8KVjKLjAxE=;
        b=QcHX4nLLIny4sIe7kDcdAVuVaocOLXowoAX+eapQR0SX7wIBfOtruP9HkKuT8Io/Y6
         zWrMsUkXPl1nBZ4qrrsPMacUB1RaFAn1VMCFCUnbZXQt1gxgJfuG0WIGCTsDQEgzskgd
         6tkaeN+/gHFdpTB91hDwInajohb2rEkhbJRyM23tLVvGq3xaxZk4TNu6DiZCztqQYOTO
         mYEKRf1hUw/B+0Tt5WQQwXbCppkdRiSGWS6Q/a7gwqeqn61zafkeGC6HI/vmVW/x+3xP
         yvzVbubUgGr0dL7D+iajU/C7MbJF2syVWr2bC+2DNIiJ6qHlvmmcpdFzsdBRT0GfOFxY
         cJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790829741; x=1791434541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XIBJllRq9Qoioyf410EUtaPM6Z2WKPJiq8KVjKLjAxE=;
        b=srdVFyraRbeie5cRpRLUoTp7eXWsmsVXUNc6O0P2bfGJu/LVDwinIZZMZq7s3VYZRv
         pEMbJruqRYmEfqwYKHeEptA1qnMoeUHYrhfexN/M2d9k2JTo9atzFjpN+LEgI6VhBsTG
         Kb5gnjiSf2JzVwAJ+4aNb9bJOiNsFADY9B92Bi+9odub3RgL7hOSWFYzxniMrAOw2tWF
         eGwWOx8rCKEbNImM1RJNgqu5hDo6lI4rVhGetWCAfSNtPVieg8wsXtIF9VbtDhVKWpCY
         e9bRmlfu4BBbUOczcCfUyepXKvd6p1Oo8OQlEBS0cSb5jHh7Xx/rB59Gpk6yO97fBHqh
         F3PA==
X-Forwarded-Encrypted: i=1; AKwUvByIwvoscmqFUDBC60GckIx87FFca+cv0XeEkpi+fQDf+VGmwvuYa5g3KcNvI5dFHz2K3EbKtVbYpphGEgmLcA==@lists.linux.dev
X-Gm-Message-State: AFuF++neqi0X6S2fa/tXwruieSBSlsulbCj1v1qZn+m6eInBzu+UZbwD
	NoresBG8lokq7+oCZi/2T5+9YoxxnFU9Se59bYKklNkLPBkkAr8rsrkj
X-Gm-Gg: AYBFou2qQA/5y5evoyqwEL7ecmBo4ziby5jwrVZqlVLAQ56XXy7BeESQN0LK20hwjox
	7FJCeJKxw9/0hd4wrk6oxlxd/DKuDOCWgHMGPmca8xCzWR9kHYaSazrvoGKFHGuyLrrhQzatvvt
	vP1KcJUjQgys3ennF679plmSep5SUslAFwWFb9URKwtoBzTTbOeiPhC3EaQCchT3RyOpzH2G/0Y
	JDRcHJq6Rpjpq3eQfgGzmpPqaFuL6UoMoNnXxKrsqvfLzdxjuMo5a5nCfSfvIex12TwWudInZt+
	ACMcKbyvjgapEkWhjM5HqxWPWcSm0V0MbTGqe+YYZ5Uotbk2GgTpxPzK6mmnQhbbP68Ki7wSuP+
	Z9uYKXJa0htspYPJkoLZ+/AMcaTCfXEeHBBiih+3GGMsBKmtAuWVazhAFYmR2QfpQ5tn7SHP7zi
	pL5/u8oOQ6OFFJY+ALZjoi+pYueycz8lCuz7HJuQazJN9g3FDd9yee8F6AtE9jvDxndwo5v5Jjg
	sVG0mZjuiAujMcATz4bZxgSv0mcMruEQ4s0p7peFxYlRb6kRwVknz64xKm6/fWTTwaq19xn4RWW
	vW5LbTXRo0ACzQFh4/i72nDHgW+EL9GQEQIsEWo9sBh/gK1Xi5E=
X-Received: by 2002:a05:600c:83ca:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4a01eaf59c6mr25440045e9.2.1790829741006;
        Wed, 30 Sep 2026 21:42:21 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-095-117-056-101.95.117.pool.telefonica.de. [95.117.56.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f6c5059sm32619515e9.0.2026.09.30.21.42.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 21:42:19 -0700 (PDT)
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
Subject: [PATCH 2/2] mm/memcontrol: defer final objcg release from no-lock frees
Date: Thu,  1 Oct 2026 06:40:56 +0200
Message-Id: <20261001044056.75079-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261001044056.75079-1-kmehltretter@gmail.com>
References: <20261001044056.75079-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kfree_nolock() and free_pages_nolock() can drop the last reference to a
killed object cgroup.  percpu_ref then invokes obj_cgroup_release() in
the caller's context.  The callback can uncharge pages.  It then takes
objcg_lock, exits the percpu reference, and schedules an RCU free.  A
no-lock free can therefore enter regular locking.  On PREEMPT_RT this
can take a sleeping lock while the caller holds a raw scheduler lock.

Make the release callback add the object cgroup to an NMI-safe lockless
list and queue normal irq_work.  Drain the list outside the no-lock
caller's context.  On PREEMPT_RT normal irq work runs in irq_workd task
context.  On non-RT the work remains safe to run from hard interrupt
context, as required by the existing release path.

Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/linux/memcontrol.h |  1 +
 mm/memcontrol.c            | 29 ++++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7d1c0ce189a88..c755d946430b6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -186,6 +186,7 @@ struct obj_cgroup {
 	struct percpu_ref refcnt;
 	struct mem_cgroup *memcg;
 	atomic_t nr_charged_bytes;
+	struct llist_node release_node;
 	union {
 		struct list_head list; /* protected by objcg_lock */
 		struct rcu_head rcu;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 856a7d07586cc..63b18c7f1965f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -33,6 +33,8 @@
 #include <linux/sched/mm.h>
 #include <linux/shmem_fs.h>
 #include <linux/hugetlb.h>
+#include <linux/irq_work.h>
+#include <linux/llist.h>
 #include <linux/pagemap.h>
 #include <linux/folio_batch.h>
 #include <linux/vm_event_item.h>
@@ -146,9 +148,12 @@ static void memcg_uncharge_kmem(struct mem_cgroup *memcg, unsigned int nr_pages)
 		memcg_uncharge(memcg, nr_pages);
 }
 
-static void obj_cgroup_release(struct percpu_ref *ref)
+static LLIST_HEAD(objcg_release_list);
+static void obj_cgroup_release_workfn(struct irq_work *work);
+static DEFINE_IRQ_WORK(objcg_release_work, obj_cgroup_release_workfn);
+
+static void obj_cgroup_release_one(struct obj_cgroup *objcg)
 {
-	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
 	unsigned int nr_bytes;
 	unsigned int nr_pages;
 	unsigned long flags;
@@ -189,10 +194,28 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	list_del(&objcg->list);
 	spin_unlock_irqrestore(&objcg_lock, flags);
 
-	percpu_ref_exit(ref);
+	percpu_ref_exit(&objcg->refcnt);
 	kfree_rcu(objcg, rcu);
 }
 
+static void obj_cgroup_release_workfn(struct irq_work *work)
+{
+	struct llist_node *node;
+	struct obj_cgroup *objcg, *next;
+
+	node = llist_del_all(&objcg_release_list);
+	llist_for_each_entry_safe(objcg, next, node, release_node)
+		obj_cgroup_release_one(objcg);
+}
+
+static void obj_cgroup_release(struct percpu_ref *ref)
+{
+	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
+
+	llist_add(&objcg->release_node, &objcg_release_list);
+	irq_work_queue(&objcg_release_work);
+}
+
 static struct obj_cgroup *obj_cgroup_alloc(void)
 {
 	struct obj_cgroup *objcg;
-- 
2.53.0
