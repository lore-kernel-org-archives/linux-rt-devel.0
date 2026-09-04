Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8844E441618;
	Fri,  4 Sep 2026 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515883; cv=none; b=i41Dg79Tnj/ijrO+Ew6cX39Jq09LvfbzAt4JQLV3unBJy1dkN1fQCpokriZsJIckv3MdUq+YSSKXd5dcrQVDgjUEnYAwfKxA4nC9rvqjfgsqQ8jneDMp2MKzFipzqboprgMQXaSac/DqQp3iQewYBDbriit4mlhmq31xqn0E26E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515883; c=relaxed/simple;
	bh=J4Uw3P4IlJYZ6wx9/AajjAoW9Zv4s9xp+fBZy1dlWWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Em34yAQx/zYGbEwjiCsD4MudhJx5z66kzfdHiWOcc37wP8004Qyg3M+GU7ddmZFw5o6RIeR7BC61yDlk4KA3bR0iLayrtwf+wxqoe0J2iFnJIoLMlAr6h8LVY5kh5qVvZOgwckRDPYwgi8dFj8h64ItcygobAPLQevco5X3Yu/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXl+95NG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXl+95NG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7204F1F00A3D;
	Fri,  4 Sep 2026 09:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788515882;
	bh=84RQjvUIbZegelFgUCwrD+5Gg8PBRCldn9ArQR1bQ0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HXl+95NGCkRn8wpoJGvYycHo6AFaZsZMhDw8m68jymnrceifFIzGIlqfOs8JNnCNS
	 ndprzaCRxDNXYtrz2A2B0DjKXBH6/qTAXIJl/SoPyxrZwwkHwXB6h3YjDS0vQmpJbw
	 FU64XqtGrRI0dTQ3q9MqUVCe8TPxCHSJpBuPjXmESI8ommzpz4g9wPhnMMD2eQW5wi
	 YP0XLHJug5Crdf2Cd2Ewyc4Mfb4/a5hWceLXfL049a1IlD39ID5VMR9f4n5sg7k9KV
	 KxpQtTMAYWOFgv0i20IDqwo0HOTgaE20eL3Pp1t+/HSyooz1pVXv/BSvyCbPv/CWYg
	 blDgD6ygsVJgQ==
Date: Fri, 4 Sep 2026 10:57:56 +0100
From: Harry Yoo <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	syzbot+acf142088e0182172e58@syzkaller.appspotmail.com, ThangNN99 <ngocthang2710.1999@gmail.com>
Subject: Re: [PATCH] mm/slab: disallow kfree_rcu_sheaf() on PREEMPT_RT again
Message-ID: <apqS7Z3F5Rtq7caz@nixos>
References: <20260831-b4-kfree_rcu_hotfix-v1-1-4f0fb882638b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-b4-kfree_rcu_hotfix-v1-1-4f0fb882638b@kernel.org>

On Mon, Aug 31, 2026 at 06:02:38PM +0200, Vlastimil Babka (SUSE) wrote:
> This partially reverts commit 2a8bb29ec9b2 ("mm/slab: allow
> kfree_rcu_sheaf() on PREEMPT_RT"). It was based on an assumption that
> local_trylock() is safe on PREEMPT_RT from any context.
> 
> However kvfree_rcu() is also called by set_cpus_allowed_force() with
> task_struct::pi_lock acquired and there it's not safe, as syzbot
> has reported.
> 
> For the immediate fix, skip kfree_rcu_sheaf() on PREEMPT_RT again from
> kvfree_call_rcu(). In theory, kfree_rcu_nolock() would have the same
> problem when called from under pi_lock on PREEMPT_RT but that can
> be addressed if such a caller is proposed.
> 
> Add an explanation comment, courtesy of Sebastian.
> 
> Reported-by: syzbot+acf142088e0182172e58@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=acf142088e0182172e58
> Reported-by: ThangNN99 <ngocthang2710.1999@gmail.com>
> Fixes: 2a8bb29ec9b2 ("mm/slab: allow kfree_rcu_sheaf() on PREEMPT_RT")
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon
