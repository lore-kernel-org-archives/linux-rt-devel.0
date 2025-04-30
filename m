Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB22925E44C
	for <linux-rt-devel@lists.linux.dev>; Wed, 30 Apr 2025 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017301; cv=none; b=k9vjT2BYPWu1jOC9kj8KuCUl8i8s/r96QtPNc5YT9sQyQGkwXFhImWXTjrDnHbMFtmPWwNntOOb1bkPfuZL1yguRPt7GOFdH5O9tHVvJfnro3fNbPZ6y5QKAA6YxU6HERNflY+xH00G7ZMnrIu6MsrXGArXV/BHxP3My2OZXTbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017301; c=relaxed/simple;
	bh=znTzkElG+15BqXoaBmnxoK9Wf2NNmf8iaeTKQhTwaWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hp1xUzvQeL59NdN2xuDA8JgWw8ZwZCJe11P3A8vENQeCrib59oTRVjtCxfM9OL7bzy+/Nd3atEvQbzdkMzdIA/oXuslSuCaQrIiFOsV3hZ/VK0c4IeY15ChKMony4ZNfwjs4TeLll4Oldttm5jEtiFmYjCjxsZROf0xQntVP41A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ENQ42zlp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9/pTLuPa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ENQ42zlp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9/pTLuPa"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746017296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aD3CNIqIdKGjQEvqGC7xw6ktmCbjt3ZQtV6T8srOrPY=;
	b=ENQ42zlpITriOvy3cA9tza4E+mHey9QrbRsIJKLNho+8eI4hnt95H2ub2ont3UsLjSN0se
	xY4CHG54WtA9iwi298WwMO6zC5R3WRR0behPqc4/VeSiiibHW1FrigvM4xWANErKsVNKAH
	MOL5OGfaTBpO7Mxips05EHdfNckLrrxlx0bOlIRgoclHM+XtUsBVdQkxopoUi+oUnK2Flz
	6WvS8niPYtDo4O9tbE+Stl/DIYmMmT9dJ3hN5voqh+T++vIZMFBB7e3xtdyPcAMnsL9MX5
	6SJq1zL+Kh3mQdn7/5g28xS8E14vwI1H1nw/jBJlHzbUYfla7O33dpcpNJbFKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746017296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aD3CNIqIdKGjQEvqGC7xw6ktmCbjt3ZQtV6T8srOrPY=;
	b=9/pTLuPa/62/zG/NuMq2vGW5DXS+3jsApKxKRgdh5UfV/Ap+AkeVRVVEMSq29PXdmcoHmw
	uaJssy02UmxIDNBg==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Allison Henderson <allison.henderson@oracle.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v3 18/18] rds: Use nested-BH locking for rds_page_remainder
Date: Wed, 30 Apr 2025 14:47:58 +0200
Message-ID: <20250430124758.1159480-19-bigeasy@linutronix.de>
In-Reply-To: <20250430124758.1159480-1-bigeasy@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

rds_page_remainder is a per-CPU variable and relies on disabled BH for its
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
this data structure requires explicit locking.

Add a local_lock_t to the data structure and use
local_lock_nested_bh() for locking. This change adds only lockdep
coverage and does not alter the functional behaviour for !PREEMPT_RT.

Cc: Allison Henderson <allison.henderson@oracle.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/rds/page.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/rds/page.c b/net/rds/page.c
index 58a8548a915a9..afb151eac271c 100644
--- a/net/rds/page.c
+++ b/net/rds/page.c
@@ -40,10 +40,12 @@
 struct rds_page_remainder {
 	struct page	*r_page;
 	unsigned long	r_offset;
+	local_lock_t	bh_lock;
 };
=20
-static
-DEFINE_PER_CPU_SHARED_ALIGNED(struct rds_page_remainder, rds_page_remainde=
rs);
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct rds_page_remainder, rds_page_r=
emainders) =3D {
+	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
+};
=20
 /**
  * rds_page_remainder_alloc - build up regions of a message.
@@ -87,6 +89,7 @@ int rds_page_remainder_alloc(struct scatterlist *scat, un=
signed long bytes,
 	}
=20
 	local_bh_disable();
+	local_lock_nested_bh(&rds_page_remainders.bh_lock);
 	rem =3D this_cpu_ptr(&rds_page_remainders);
=20
 	while (1) {
@@ -115,11 +118,13 @@ int rds_page_remainder_alloc(struct scatterlist *scat=
, unsigned long bytes,
 		}
=20
 		/* alloc if there is nothing for us to use */
+		local_unlock_nested_bh(&rds_page_remainders.bh_lock);
 		local_bh_enable();
=20
 		page =3D alloc_page(gfp);
=20
 		local_bh_disable();
+		local_lock_nested_bh(&rds_page_remainders.bh_lock);
 		rem =3D this_cpu_ptr(&rds_page_remainders);
=20
 		if (!page) {
@@ -138,6 +143,7 @@ int rds_page_remainder_alloc(struct scatterlist *scat, =
unsigned long bytes,
 		rem->r_offset =3D 0;
 	}
=20
+	local_unlock_nested_bh(&rds_page_remainders.bh_lock);
 	local_bh_enable();
 out:
 	rdsdebug("bytes %lu ret %d %p %u %u\n", bytes, ret,
--=20
2.49.0

