Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF41446AA6C
	for <linux-rt-devel@lists.linux.dev>; Tue,  1 Sep 2026 07:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248025; cv=none; b=oDWqvzZQa/UNcWs2SprcYKV/+/UA34vnzrji0mNjwtuEsRGGELuTHmDIYoYTUfRbzj0h3b5M8uMsULqGa9RpKd13JZavGy89dickJtXVgqLQsAPI95rBiPgohzeDlgQZ9FkHWKoyogCI+vy4WP0sdF/RWET99JiCGrRYpnUK5ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248025; c=relaxed/simple;
	bh=27tX09Ku1yUGrS5nmgj4LhtsjBb7cHNJOk2p+V8FmWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XToJtl4MK9BvspnS5Pomgy9FuCFCSO2BNJjCyrJMQzHjtrMmKR1n1DNul9IOaBbgeQLj/yXZOu7KfuTDlZkrGr9hI/JH9NHu9nLzBOT8isdFOUoUZ7Lo/zmXCF2l9gnNHe6jDUn7undwFSPvKJnktqtxYZdK8OROVcZKn4Qd8Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TzXPT7Dz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j5HparhZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TzXPT7Dz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j5HparhZ"
Date: Tue, 1 Sep 2026 09:33:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788248020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=27tX09Ku1yUGrS5nmgj4LhtsjBb7cHNJOk2p+V8FmWM=;
	b=TzXPT7DznQcsARnerro9taiipvSEM2X4U6+EbW/xr0uCME3BEEanTcS3RZhQRaKNv0rNvk
	xLbOEj2o7nhwUkqENBSWmmQaneC5z0upECKOVEg7ddZZgaiHc+F8OkPvYhI1M5XI+/rv7R
	7+GCjWG1qrxKVUYbvb3qO9z7G8FBZ+EGBC0/PfmaIisZewxwvyzGN7T0pCBXk14Xh6vaMe
	WoK+lp2PjmP+gSyE7q4G/BqhFM7RCl+iPxiG2tcFRmY7/FVMKvsEhq2pzWJKTu4WwgR4YD
	tIYR9Oet+Deeo//rNW5xbdDusLTe39SixfjGT9K3QS3v/r89NkNBY2q9+mL4SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788248020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=27tX09Ku1yUGrS5nmgj4LhtsjBb7cHNJOk2p+V8FmWM=;
	b=j5HparhZ5Xj8SedssfmGWoPfae5sXvItOLzUQ2qVxQ1rNXl/NIuvUgxPjxIUaeOrCN+8f6
	gF/WO4VMNvyDGuCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>, Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	syzbot+acf142088e0182172e58@syzkaller.appspotmail.com,
	ThangNN99 <ngocthang2710.1999@gmail.com>
Subject: Re: [PATCH] mm/slab: disallow kfree_rcu_sheaf() on PREEMPT_RT again
Message-ID: <20260901073339.uyKHXWCX@linutronix.de>
References: <20260831-b4-kfree_rcu_hotfix-v1-1-4f0fb882638b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260831-b4-kfree_rcu_hotfix-v1-1-4f0fb882638b@kernel.org>

On 2026-08-31 18:02:38 [+0200], Vlastimil Babka (SUSE) wrote:
> This partially reverts commit 2a8bb29ec9b2 ("mm/slab: allow
> kfree_rcu_sheaf() on PREEMPT_RT"). It was based on an assumption that
> local_trylock() is safe on PREEMPT_RT from any context.
=E2=80=A6
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> ---
> Incidentally I have posted a RFC [1] that leads to replacing that
> kfree_rcu() from set_cpus_allowed_force() but now after back from
> vacation I need to check the feedback and based on this bug report I can
> already see it makes the same bad assumption that trylock is fine.

free_to_pcs() has still this trylock.

What I am not so sure how good is that kfree_rcu_nolock() may allocate
memory for the sheaf if there is none around. It could have a pool of X
and if it runs out, it runs out and waits until the clean up process
feeds the used sheafs back. There is fallback and the run out is not the
usual case.

I do remember RCU tried the same thing but then it got to the case where
HEAD had to be supplied or it had to be preemptible so could wait for
grace period and free it. I just don't remember if it had a pool pages
to fill pointers to or allocated pages if it run out. And I am too lazy
to look atm.

Sebastian
