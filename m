Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FDE1DF25F;
	Sat, 28 Feb 2026 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293803; cv=none; b=PQvjGK1Ed3EatYrz40QnrM2EFRWKzv0+iz9HY7pDgwKeJc++fO/VxSCD7FHzptJHPFgjKjR/luk4uAHMkWoqpOPpQWJaMP95lMmY8SeUCvJCTT5awlz280E/pY784czJzfRili6TAAoKGZ59NAhLrLMQQRKB7Z3rPXgAQUlqTcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293803; c=relaxed/simple;
	bh=U7iU0O708MosLKMperst8qs1501dpeYaYOoeaCGJkNI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T0gb24KRoH76ZxHb8SvwY2WDi/rKMtO9w8/pC6hkQcFisYn6Wa8u6HldK3/NRDzKVqwaVkPr/IZyun52est0Z6oOUZQvuaaGycGLheFdCyn10/k8OUlxv/XQpVzfOkWDI2BXVOki9ou9Zaeg7lNISmJaYXo6JuGw/ue8pBpuWKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aE2yZFOC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aE2yZFOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD869C116D0;
	Sat, 28 Feb 2026 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772293802;
	bh=U7iU0O708MosLKMperst8qs1501dpeYaYOoeaCGJkNI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aE2yZFOC0fnwzQOlWC1Yx5ESs6IvmPreJFiJyQAU+7CGhnDeVAeMlsobnmJXykLov
	 PhFyylnY6FNb4ywBlKkMxMeUVFlFY0kW6gukd5AvmjIsGZcyOjyQ008eQUyqX3GqR7
	 ycOaErmRgFtTzR6dFFK8x7hohpg3gMOfqvBmEjwZqUwG/F9558dF/Ec6IsxJilMgIB
	 u3w4RqCCJKVNKhG6ecNJHKKsqd9dZ79/QXUmNKY6WGux7CCx/WXp14Kd6A3OUGy4TM
	 sKiaEUxH7pH3rCVz8QD5gry5Q/jj01i0qWnH6M/CiUMrfa23lBvp5AGsV7kFNFAXBC
	 nQGJrILo+Y9ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD9D39F2021;
	Sat, 28 Feb 2026 15:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: fix sock compilation error under
 CONFIG_PREEMPT_RT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177229380605.3002732.13851051513590754007.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 15:50:06 +0000
References: <20260228111319.79506-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260228111319.79506-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, edumazet@google.com, jiayuan.chen@shopee.com,
 kuniyu@google.com, pabeni@redhat.com, willemb@google.com,
 davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 kerneljasonxing@gmail.com, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 28 Feb 2026 19:13:18 +0800 you wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> When CONFIG_PREEMPT_RT is enabled, __SPIN_LOCK_UNLOCKED() expands to a
> brace-enclosed initializer rather than a compound literal, which cannot
> be used in assignment expressions. This causes a build failure:
> 
>   net/core/sock.c:3787:29: error: expected expression before '{' token
>    3787 |                 tmp.slock = __SPIN_LOCK_UNLOCKED(tmp.slock);
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: fix sock compilation error under CONFIG_PREEMPT_RT
    https://git.kernel.org/netdev/net-next/c/58e443b773ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


