Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9D0282F12;
	Tue, 28 Apr 2026 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368649; cv=none; b=UNd4qPaKVFYeRzv0SpAdBMELKAEj6zd0WodBQ0xIo3FetQN+Mg9xvLJbXHFVzMcb3Tg/mAOq9QYUslq7JW69TYG2mYADs9w/vgA6yyEuZ3sFZxx2N/Tl4QNpmyKNQEyyYkNea8MVZjxUXgDYjH0mEiIjzWPuEQmj9sfq6BYGiFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368649; c=relaxed/simple;
	bh=2pwslKpeN/iRQaRc0dF+AWBbRO46umamJewOKVHPoVg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s0AJm+eljgJ1SQFyREZzCjNsQ6pZf5AGc398szR5rQ3G5xPJ8hE7f2/f4cSrJhB3wxb9jSTN5vjOf+sPmD1gF89xNao2i0irjJOuv4sNBwk7wWV01gEfWEatLwurCPMN4BID9orwjCjTurCyc15babJlC0LSZbqWdS947QsoqY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgZXbprI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgZXbprI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABD4C2BCB6;
	Tue, 28 Apr 2026 09:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777368648;
	bh=2pwslKpeN/iRQaRc0dF+AWBbRO46umamJewOKVHPoVg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OgZXbprItVUneu0OPaDMO5MVnJNJQkKQjpdLGEL2cK4nzDwaiYAxTIKFZS/sNboli
	 YGSXUOise7tnFE+tWv7hSl2aYHeFT1MtS/L/LYHi1TXnKZ/AsTJBOA5ISkHvIzBqnM
	 NwnQ6PzSTpIPF+Qls2LFd2PQCOGV0pr/5H+1DUF6DSOLmia3Et3MrNXUhYYnkHZB5A
	 TJu0FGtAmjZwzMeHXwT9ZUQjYhVveLnvunMxHqmO7xnBxsDAimCvN83/0+S5cAte+Q
	 Jdd+n12SFVe0NQpHaJxbTzOkBhO4CXZ8eN3N3qq19dCKAEXbOkH841KmzaoyEvHy86
	 Kv0jcAoldxTHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0B33930189;
	Tue, 28 Apr 2026 09:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ipv6: fix NOREF dst use in seg6 and rpl
 lwtunnels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177736860530.369431.11395917276925436153.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 09:30:05 +0000
References: <20260421094735.20997-1-andrea.mayer@uniroma2.it>
In-Reply-To: <20260421094735.20997-1-andrea.mayer@uniroma2.it>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, david.lebrun@uclouvain.be,
 alex.aring@gmail.com, stefano.salsano@uniroma2.it, netdev@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 21 Apr 2026 11:47:35 +0200 you wrote:
> seg6_input_core() and rpl_input() call ip6_route_input() which sets a
> NOREF dst on the skb, then pass it to dst_cache_set_ip6() invoking
> dst_hold() unconditionally.
> On PREEMPT_RT, ksoftirqd is preemptible and a higher-priority task can
> release the underlying pcpu_rt between the lookup and the caching
> through a concurrent FIB lookup on a shared nexthop.
> Simplified race sequence:
> 
> [...]

Here is the summary with links:
  - [net] net: ipv6: fix NOREF dst use in seg6 and rpl lwtunnels
    https://git.kernel.org/netdev/net/c/f9c52a6ba978

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


