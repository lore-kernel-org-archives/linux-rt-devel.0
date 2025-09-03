Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8085139E;
	Wed,  3 Sep 2025 00:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756858181; cv=none; b=d0B/v2Qsa8r/neudJx9AcxaTNEN+BXB3irLjOZGrjbzFOmztRYv1iLVfx1sykrhvU1xYTc6/zZyEwBsT13/F+5Fj9av2inPpLhsITUSdbNc6U7lcvaPH+7FV4PxnJxQWYIOYWQd8dnxx9yPklWcUrX+4XsEtCVFgB6YZqJfbWfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756858181; c=relaxed/simple;
	bh=USjIyRwCL+CFUqEI2L2/tVck2gTRjzbFMpY5LRj8DtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWO1DCwd2RvTWUof9yrkLK6/m6RvItkeOmwzs4K4e3sPF+SqG/I6UAmK+ePSZy2R/wieXMkHzcKpZGJwBPeX5H5OzEOD2BUzoaByM5eB0ShbrUEm/yzOjmkzUZayPIDWccw5B77Aj55l3H8WSHdG9dAFhAFhirJ8HlzyVXPM4Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TP3XhqQA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TP3XhqQA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81C3C4CEED;
	Wed,  3 Sep 2025 00:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756858180;
	bh=USjIyRwCL+CFUqEI2L2/tVck2gTRjzbFMpY5LRj8DtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TP3XhqQApzxY97uRY3XMP9xw3VFZiv7H2Md0Bvp4rW3TAK2OdtwZbaWHsrR/5Dwpl
	 zy13l8XOIDIF/ldIEtIfFGZOwH4vynqBv44cP3OY7tZy+fpPHTdGGLjxAYtW/eQMKv
	 xOAvBLezE0PsKIFbDNOy80MHKpDiI/9mDlbQ8/MSFaDcgMwzZFF1HoL06vWDc5w5DY
	 3MafrNXufNSOJ7S9CSLLJs7nk/uqSxRaqx0VdrNyYubzvPbL1GnK1Hgcutpt7TWfOF
	 KNFRdI8zVrKcCJdYhw9oaBX4FmTKcP56vxlIyKztX+IZDpfPohm/aawvp4iecd79aF
	 TxF2yp1CxpwqQ==
Date: Tue, 2 Sep 2025 17:09:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 kernel-team@meta.com, efault@gmx.de, calvin@wbinvd.org
Subject: Re: [PATCH 7/7] netpoll: Flush skb_pool as part of netconsole
 cleanup
Message-ID: <20250902170938.0d671102@kernel.org>
In-Reply-To: <20250902-netpoll_untangle_v3-v1-7-51a03d6411be@debian.org>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
	<20250902-netpoll_untangle_v3-v1-7-51a03d6411be@debian.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Sep 2025 07:36:29 -0700 Breno Leitao wrote:
> @@ -607,8 +596,6 @@ static void __netpoll_cleanup(struct netpoll *np)
>  		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
>  	} else
>  		RCU_INIT_POINTER(np->dev->npinfo, NULL);
> -
> -	skb_pool_flush(np);
>  }
>  

Please don't post conflicting patches to net and net-next.
Fixes have to go in first, trees converge, and then the net-next patches
can be posted.
