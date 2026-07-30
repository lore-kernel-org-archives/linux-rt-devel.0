Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885A5407582
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Jul 2026 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409836; cv=none; b=LJjcapxl2UYPmjmLePZi4GgFAIVSxT+lNZDTRigcHRgu/4m4D/FuPdSHwyLe5tRJXnZOZolQFTwNr4sIyPLjKnUr9nsBtN2HxQucV5tVQy5mmtWpso0E0dlkGfbnx0Cgl5Qgeocv35NvN1EiuzojjqNBhMaxim0o7RTFvgZZW4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409836; c=relaxed/simple;
	bh=lNA5KQvHQyVffTClbuD5Vllw3vyTiDZXg183QcA+3b0=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=DEdO1KIiNFJElpQQKbNP1HuzTzxII926Gif2Qo4pgWty5a6XEh7O+QdhTLZMcGUho2Ycvg71D860sRutKnaYX3e3J1dcUMJj15uRXjLwhAhRUSFfB3Rrk+uXrlzPhKpFuGFizCGzBRcDAnHWQssUm/I8OGeXL4RYQkmmQJrhO6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4h9mhN3BGgz8XrrJ;
	Thu, 30 Jul 2026 19:10:28 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 66UBAIxs066128;
	Thu, 30 Jul 2026 19:10:18 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 30 Jul 2026 19:10:20 +0800 (CST)
X-Zmail-TransId: 2afb6a6b311cd3c-c8b39
X-Mailer: Zmail v1.0
Message-ID: <20260730191020843srkTQnCknZzmYHU694CZi@zte.com.cn>
In-Reply-To: <20260729-kfree_rcu_nolock-v5-2-a28cdcda9673@kernel.org>
References: 20260729-kfree_rcu_nolock-v5-0-a28cdcda9673@kernel.org,20260729-kfree_rcu_nolock-v5-2-a28cdcda9673@kernel.org
Date: Thu, 30 Jul 2026 19:10:20 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <harry@kernel.org>
Cc: <vbabka@kernel.org>, <akpm@linux-foundation.org>, <hao.li@linux.dev>,
        <cl@gentwo.org>, <rientjes@google.com>, <roman.gushchin@linux.dev>,
        <ast@kernel.org>, <andrii@kernel.org>, <puranjay@kernel.org>,
        <ameryhung@gmail.com>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>,
        <rostedt@goodmis.org>, <paulmck@kernel.org>, <frederic@kernel.org>,
        <neeraj.upadhyay@kernel.org>, <joelagnelf@nvidia.com>,
        <josh@joshtriplett.org>, <boqun@kernel.org>, <urezki@gmail.com>,
        <mathieu.desnoyers@efficios.com>, <jiangshanlai@gmail.com>,
        <qiang.zhang@linux.dev>, <pfalcato@suse.de>, <surenb@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-rt-devel@lists.linux.dev>, <rcu@vger.kernel.org>,
        <bpf@vger.kernel.org>, <harry@kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NSAyLzhdIG1tL3NsYWI6IGhhbmRsZSB0aGUgIWFsbG93X3NwaW4gY2FzZSBpbiBrZnJlZV9yY3Vfc2hlYWYoKQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 66UBAIxs066128
X-TLS: YES
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 30 Jul 2026 19:10:28 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A6B3124.000/4h9mhN3BGgz8XrrJ

Harry wrote:
> Teach kfree_rcu_sheaf() how to handle the !allow_spin case. Try to get
> an empty sheaf from pcs->spare or the barn even when spinning is not
> allowed. Unlike __pcs_replace_full_main(), try harder to allocate
> an empty sheaf because the fallback path will be more expensive than
> kfree_nolock().
> 
> Now that slab has internal alloc_flags to describe context, introduce
> free_flags analogously and convert free_flags to alloc_flags when
> allocating memory in the free path.
> 
> When trylock fails or the kernel observes non-NULL pcs->rcu_free after
> lock acquisition, free the sheaf instead of putting it to the barn.
> This is rare and not worth complicating the code.
> 
> Since call_rcu() cannot be called in an unknown context,
> kfree_rcu_sheaf() fails when the rcu sheaf becomes full.
> 
> Link: https://lore.kernel.org/linux-mm/872bd673-3d45-4111-8a41-31185db3ece5@kernel.org
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>


LGTM!
Reviewed-by: Shengming Hu <hu.shengming@zte.com.cn>

--
With Best Regards,
Shengming
