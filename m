Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B462E9ED7
	for <linux-rt-devel@lists.linux.dev>; Tue, 16 Sep 2025 04:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998155; cv=none; b=I1YBSgQuUpdz42tV6CWXia46odelq2N1+XrDaVkXe7VDaOzH/XPIdc4NQYqHNHXNOJyDlkQZvhtGgBx72kgY0EUdNorFnPdgHAZwC+2xWbBLlpIwtFMSQIQlGxEptZuGhAaecY6hAD/Hduc/ZbuSe/4Vb/jwXXonND5eCT6FWIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998155; c=relaxed/simple;
	bh=7sG+E8vq4OG/BfLJfXnS6N7EfrLQmjqnuIf5XUjAWWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZIZvDd+tyrmpj/PFG2ySYp0N1PwgAadCl9eA5BIYy4ou2AONbWv11YciJrbmT7DxTe99gYS5BGj0vo40pFR3Bj1CPBe/xGcR/guqHyn9/XQ6AMnZykH5EGT7PKgIc7sfDOZCBCiv+1FNBrfvbTfrzBEUOLZozJC3MGuCmIcTTu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMEmNB6b; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMEmNB6b"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2445824dc27so45369275ad.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Sep 2025 21:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998154; x=1758602954; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNMpbtPTFBPk6JIOba7CD2qKlqPbw337arz8FniHJF8=;
        b=nMEmNB6bW/22JWAkzqHDuxDIaYqpbK8va9hWAvn4uFQZv4+SJB3fdkbbLLN1zl5Cr0
         B5iId6JVljdHOEmCPrVX3aXKEC+tuftHZ8aZQoGv+mmiecaI4psdkqDDQ5Vo6GTtNDnG
         asJHs8OsQQfRaIAL+psJ7XV1Rh7WXagt9L665SVjIUDOIjWfkO8O3O7CnqPcMVOZ/ZdI
         DkyO8B+yPSpBMSJKD7uDukeZx9bhc0+z7urF+xUIPB7LiFId6dCBm2eABdAkDjRnv+9v
         D5BZFvc/IgW4DzRY7tim1NcSDoiDgwtbNWb8Q6O99tBoFHfBawxhEmz8e/QbPljVBF9q
         YCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998154; x=1758602954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNMpbtPTFBPk6JIOba7CD2qKlqPbw337arz8FniHJF8=;
        b=hRmeY7hb09Wdz/YlKtW8iFnj8Okep/sLPckInE1/qRSSxIicok/QGH/H3pLrZYWGj7
         Efqy4PfwG2l9fDeNx9DVYyifZsCPmTxFo3aTE0j0ZdqxK3IX6fp39Xt6p0ca//rQiEVC
         XvDKVzo32JV7O+vzQi2b1a9G+WbjO5Ly6TQGZMJmLbYa81c8GiJVkdPts5opFjy6gxGl
         CWZQPxGFy2Adra7+jhX2rkVHQgWmMsQuDUh5jTDqnFpVEaaJ2DoV5pVYmRHiGit33LJ4
         /94qwA9sJ34mzYTVRC5/UPbjB3olJrtzu3zs6ID1hKVZSfnlRQdnOjzo8IF/Ky/wtkYZ
         CsiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt6YxeVm5GOy13vcrxxVBm+LK17L/yMAiAeeaLTblNOfUg/YnGb8pXrakP8YmT1dJIWQ62hITESCDbjeLxCw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzs2v+s+NIIn1IZ70SQxRIhk//AKQV8Wnyg3aLPhxnYLPdNsjOk
	/SniIc2clnuW7c7soxnSJIzAbF4yiIgkZAdIsOsce65d1Nx2BP91R3OI
X-Gm-Gg: ASbGncvqOA+iznDjn2qRqBrZjoO9pmK67RrR0lWeDHQHu1Yak5iL1z91cnY5k/Mj5m6
	OhMHfmO2ttbM48Z4rL8FMyQQ6jBRFWNVYT2NkEET0LVYNXmGA+JS5piKbiZjIExPA9C8VKgnsEK
	nL7SX3Mmyl/haNCas4UUGf/8i+6D0d1bCNKekdPzB7wULkGdQIhtby7fqgMS0XUoEoR+qjUDvRw
	xq1Qt2OM1BynlhKVKXTKbr1U3GeGqvJ5X25K4P+BjZJyq0F01xYfn2b2qtGdNqDq0SVsFpmftrB
	IIQr6nrrMOUNBHrm4KZVfZlkVz0X7gjvHOtIogeuB85AuS5lFbVsoIClEgsBwnuwJcl9g9jjTci
	MdRg98SycboyU+c2mE9dEcvobDdKfs8Wh0NiAk+c=
X-Google-Smtp-Source: AGHT+IESqtMzjXYDIyoiu7v1JuOroH/dzFervHo7F64ECeuOEjCMVsn8AAVx3YpgubRO047K2xnTHQ==
X-Received: by 2002:a17:903:3c2c:b0:24b:2b07:5fa5 with SMTP id d9443c01a7336-25d26663dcamr182035635ad.29.1757998153712;
        Mon, 15 Sep 2025 21:49:13 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:13 -0700 (PDT)
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
Subject: [PATCH v3 09/14] cgroup/cpuset: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:30 +0800
Message-Id: <20250916044735.2316171-10-dolinux.peng@gmail.com>
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

Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 kernel/cgroup/cpuset.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 27adb04df675..9b7e8e8e9411 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4073,7 +4073,6 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 	struct cpuset *cs;
 
 	spin_lock_irqsave(&callback_lock, flags);
-	rcu_read_lock();
 
 	cs = task_cs(tsk);
 	if (cs != &top_cpuset)
@@ -4095,7 +4094,6 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 			cpumask_copy(pmask, possible_mask);
 	}
 
-	rcu_read_unlock();
 	spin_unlock_irqrestore(&callback_lock, flags);
 }
 
@@ -4168,9 +4166,7 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
 	unsigned long flags;
 
 	spin_lock_irqsave(&callback_lock, flags);
-	rcu_read_lock();
 	guarantee_online_mems(task_cs(tsk), &mask);
-	rcu_read_unlock();
 	spin_unlock_irqrestore(&callback_lock, flags);
 
 	return mask;
@@ -4265,10 +4261,8 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 	/* Not hardwall and node outside mems_allowed: scan up cpusets */
 	spin_lock_irqsave(&callback_lock, flags);
 
-	rcu_read_lock();
 	cs = nearest_hardwall_ancestor(task_cs(current));
 	allowed = node_isset(node, cs->mems_allowed);
-	rcu_read_unlock();
 
 	spin_unlock_irqrestore(&callback_lock, flags);
 	return allowed;
-- 
2.34.1

