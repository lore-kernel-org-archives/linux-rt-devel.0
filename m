Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7962E7BC9
	for <linux-rt-devel@lists.linux.dev>; Tue, 16 Sep 2025 04:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998150; cv=none; b=UfFlyUOzE1xJSrNStiV5Fi4m/aKpH4YcQNHSqCEYXMlATzs4P+rgi0HeYh7tW94gFFTnDKaMoBkkURE/Km6+kEYuBLtAnWmVmt3J0IeewXWZ/SuxvZhkiM/LFFZJF6Bw42R3gEZ+SAwp5LZWXLAIoTMTLrlp3qcUp+7u5oYtXQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998150; c=relaxed/simple;
	bh=A1DaGpRAAYNdE/JnkBcpbGGz1TWyQSRA1+c5fRETaCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z2mWvMni9phuqD23cmDtaKLfeTNH1bH1XPFEfT7P1FE9aEEP6uPBI6lGIZtp2/ZxB1Ghshom0Z4oe+wlPHGTulv9m8YmsdW9S4GdQke2S50Oe5oATTn09JRU+NC9VAZGwjzIymb04d/BjDtl4G1oM+CQtUIGmbHh1dzNyFNI2Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqdlH2PV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqdlH2PV"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32e715cbad3so1613756a91.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Sep 2025 21:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998147; x=1758602947; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gp+N7RFYdL+M8U5Aod5ZJl4PoDAFL89oD30EaW4MsNY=;
        b=fqdlH2PVFgMhc7X2buBbl1/+GkbZhYkTNHjjADkOeNEg10rkObsLLU6r1bWcErr1jW
         Ua/JbBsQEyqWRTYfYI8rP5grGztRXfPz+qn5LNYM3Y5XfES7BNt8YUeMwF28XZntDYFR
         Vb3KEFctsaqW8N9d0zvh+KAWRYCZl8Jwla9Ks2uDnD79CsG9wBAyJZPgOnocc6j6Q4Nv
         EZwALcBZDZZhXJgjV6OaaRvpiIGqciqVri5L3gVH74s/BYB2xn3MtretbC9xZg6wkaub
         Cfj/fdxA+vlu/3Y9t4r7Ym/gzA+7hfvJDlW8niw8JGdQoEKJJdFONG4qQ1mBrjLvqZjK
         4Smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998147; x=1758602947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gp+N7RFYdL+M8U5Aod5ZJl4PoDAFL89oD30EaW4MsNY=;
        b=i6S8wZykC18hwbakOs5u3AIh7l0auIqJyfJCb610ibtQ0+0ePDlcCY7cXuFnpD6mJT
         R8xUAv8sOfVg0gQK0f8/AvgLnvsyjhiGyG/pubJvSHjJjxxKQbovmJ33ocy2SjbVTHFw
         N4KmqNinYO2+7cUNKWxVSlwxK+0T2K0ziD+76BLmQgZ9EFtbelBaIVeadmf1cs3TvSqb
         LntlRF5pf+5PlaSpcl0gs4LKUhxOyQjdomNZbXZ1vyqxQ6T2E2LBtPFAJGMAL9rvFA9l
         Xiu2Nd5LGi/OHfFRrbHHZnY1j52m4z8lqwDUDYJnpBLIgxW2yVNmsKXRs/8JypGtu1+E
         m0Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUtQDZ5wkjGXNQjCDK1+0lyjEW2hVif9SwAAGUGMOC+KyLXUqWrL3aAfnXq85muwUk83NDPsqHqAm2FmbWvpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFjHq4n7T3I6boHzLwRZ4C9b1UHFqrjelS9JZamLf+ftLQCQJV
	NJa+dzODrQeofzNGRUFLD59t5KAeuNcj0dHv1AoRQn4QILqt6rz3fhMG
X-Gm-Gg: ASbGnctE3QlKxR4QO+1ZINfsMqrZ/w1UIFYQIgO/ZKGMmnIkqeH4ee7y26RwzQM+k0A
	elRGiz/JPZaGafVL7vqRp+GnIcQti37K41yhWABtHY4YeZ4fY80Uy6gH/OiTolLAg68kdQtxm4Y
	8YWChhpkb8jo7l6cc7I7Wy2n8GCsei3yE4Sg6fjsYcWQQXS6+eXb9sQv84vt+O2SZTfU++q1RSQ
	PTBL0rhZPYRP3pBiCjOpvN1dZlJrlXMd2DIIbnWGTjjx3MfoHrwOQMB0Z9LzNkfQ3DCydykUeT1
	GXp/6W5+lVEPLhAL02wT+4afsLdH/DyBF8zz0oPqTJcMkGjcIEhxRhLeUjBje1vyIf1gLd0vLhC
	7lmfJvBxjpUoTYEIQ1OnLgJrwrF60wxzRb2xGIdU=
X-Google-Smtp-Source: AGHT+IFqD7sgMgos1nHHN1tffY5PC8RBagTW/SlAHYpHIH6iPNz9WSa7pJxkI6T7wvTsG+plknRS6A==
X-Received: by 2002:a17:902:f70e:b0:266:120a:29c7 with SMTP id d9443c01a7336-266120a3078mr75581275ad.6.1757998147150;
        Mon, 15 Sep 2025 21:49:07 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:06 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 08/14] cgroup: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:29 +0800
Message-Id: <20250916044735.2316171-9-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 kernel/cgroup/cgroup.c | 2 --
 kernel/cgroup/debug.c  | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 312c6a8b55bb..db9e00a559df 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2944,14 +2944,12 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 
 	/* look up all src csets */
 	spin_lock_irq(&css_set_lock);
-	rcu_read_lock();
 	task = leader;
 	do {
 		cgroup_migrate_add_src(task_css_set(task), dst_cgrp, &mgctx);
 		if (!threadgroup)
 			break;
 	} while_each_thread(leader, task);
-	rcu_read_unlock();
 	spin_unlock_irq(&css_set_lock);
 
 	/* prepare dst csets and commit */
diff --git a/kernel/cgroup/debug.c b/kernel/cgroup/debug.c
index 80aa3f027ac3..81ea38dd6f9d 100644
--- a/kernel/cgroup/debug.c
+++ b/kernel/cgroup/debug.c
@@ -49,7 +49,6 @@ static int current_css_set_read(struct seq_file *seq, void *v)
 		return -ENODEV;
 
 	spin_lock_irq(&css_set_lock);
-	rcu_read_lock();
 	cset = task_css_set(current);
 	refcnt = refcount_read(&cset->refcount);
 	seq_printf(seq, "css_set %pK %d", cset, refcnt);
@@ -67,7 +66,6 @@ static int current_css_set_read(struct seq_file *seq, void *v)
 		seq_printf(seq, "%2d: %-4s\t- %p[%d]\n", ss->id, ss->name,
 			  css, css->id);
 	}
-	rcu_read_unlock();
 	spin_unlock_irq(&css_set_lock);
 	cgroup_kn_unlock(of->kn);
 	return 0;
@@ -95,7 +93,6 @@ static int current_css_set_cg_links_read(struct seq_file *seq, void *v)
 		return -ENOMEM;
 
 	spin_lock_irq(&css_set_lock);
-	rcu_read_lock();
 	cset = task_css_set(current);
 	list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
 		struct cgroup *c = link->cgrp;
@@ -104,7 +101,6 @@ static int current_css_set_cg_links_read(struct seq_file *seq, void *v)
 		seq_printf(seq, "Root %d group %s\n",
 			   c->root->hierarchy_id, name_buf);
 	}
-	rcu_read_unlock();
 	spin_unlock_irq(&css_set_lock);
 	kfree(name_buf);
 	return 0;
-- 
2.34.1

