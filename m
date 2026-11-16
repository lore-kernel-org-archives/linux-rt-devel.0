Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794800645;
	b=fPqm4UKejNBh48O2A/kJGhrFEFFpgpCfJMwuJM+M+bcn4trp8dUkEzMXfbZynpIjbhPJ
	 aagD1sNrtxaeDiAPo2URFlZ5nG+t8AN/Xp5HrJnugk6/w/WoAdP8O48k1G2MQo6hXizo+
	 +QmsuvNmZdNr0mCXiboYNq+Uihtl3gcXFzfVSFsjP9CFM1RAM76h/R5c4uAwXj4oDH+x5
	 /8eJOChqOfnB47gteHXfgcVwbBmq+2BanVTC7EqoTUiYcjSumVapfSuF7jUBKe/3LKXfr
	 HkM8hi9uKbRkt0agO19Iq/xEC2bgc5JV0R+zll/i+/ds/w+B0PGSfTcWTOKIe/K5XFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794800645;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-Id:In-Reply-To:
	 References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vLeSRzbCytnZXNus5jLvaHfW3mKYG8u2Hq9MNKiQaJc=;
	b=5K4g2ZRm1yOTcFH+LlKYa7tn0VpYwg0zHTMqNYGgazaRTq0oIyIg+OzulmwGgzr/wn6k
	 rfjzhU8ENRQjDfGqtVqa9a7tNEcUUsa5phR6yLtqs4zmVf4M2AbjMMT9SPXtdMVi3KLGC
	 QofQegLjn4zaVZxKuCqLVBkxAeVhHk9fbvNpy/7kY/flZFBlwOx5pUW0tVzESR1KCfwm3
	 /wRmi3FcwFjb1T7cTE0DwP0mql7JtDzDO+q5UpWp9FJFWErzzpIurzrwqYIgKfXmBFsI/
	 muBFVJFNH+jh3jzk3HeSr+WfStFQas+USHmA40oNKzO8bqfdkjeOm+8aT6ZOdl+zb7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=0dYFo6CO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA69606A31C;
	Mon, 16 Nov 2026 03:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=0dYFo6CO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D862C1F000C4;
	Mon, 16 Nov 2026 03:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794800645;
	bh=vLeSRzbCytnZXNus5jLvaHfW3mKYG8u2Hq9MNKiQaJc=;
	h=Date:From:To:Subject:In-Reply-To:References;
	b=0dYFo6COd5e4jza16vX0GgnRiQwhcpkoC72T/5GM9HYvGLzjzr0L5LvmJPsFm5zWg
	 R9Zztxn7YHiRRzbnyxYV+3KB8p4smv63q2CrSCc3/dzietkS3agZMK3NXfw6vtdWxL
	 MoBcwzGfgGf/vRXULlElKpN/Eul4Z/VCEfVmsvqI=
Date: Sun, 15 Nov 2026 19:44:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jiebin Sun <jiebin.sun@intel.com>, dennis@kernel.org, tj@kernel.org,
 cl@gentwo.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 linux-rt-devel@lists.linux.dev, tim.c.chen@linux.intel.com,
 tianyou.li@intel.com, wangyang.guo@intel.com
Subject: Re: [PATCH] lib/percpu_counter: allow concurrent sums with an
 rwlock
Message-Id: <20261115194404.a8d751a7c17904c756b16b61@linux-foundation.org>
In-Reply-To: <20261115191636.f18859e4dd5f58b9a33e7814@linux-foundation.org>
References: <20261116015655.2744577-1-jiebin.sun@intel.com>
	<20261115191636.f18859e4dd5f58b9a33e7814@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Nov 2026 19:16:36 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> > stress-ng dentry test average throughput change:
> > 
> >   +------------------------+------------+--------------------+
> >   | Case                   | Unit       | Average change (%) |
> >   +------------------------+------------+--------------------+
> >   | Dentry, 64 workers     | bogo ops/s |             +47.34 |
> >   +------------------------+------------+--------------------+
> > 
> > Dentry ran on ext4 with 64 workers pinned to physical CPUs:
> > 
> >   stress-ng --dentry 64 --dentries 4096 --timeout 20s
> 
> lol, this is a fun patch

It's *probably* OK, for sane workloads.

But if some workload is busily running percpu_counter_sum on 1000 CPUs,
how is a writer ever to get in there to spill ->counters into ->count? 

Modern rwlock_t does implement queuing, so the writer will get in
there eventually.  But nothing is simple any more - there are
complications with rwlocks on PREEMPT_RT and with interrupt-time reads
(do we even do that?).

So I think indefinite writer starvation is a risk here?
