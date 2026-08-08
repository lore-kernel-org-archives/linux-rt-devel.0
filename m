Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2D026AC3;
	Sat,  8 Aug 2026 01:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786151231; cv=none; b=f6dTjQHnW1HEDMaMJ1leietyjKSClQl5un8jMENmxOqtGEHm1oa/g2IoXH4IK47LQwTfxpYS59+cF7cGfqH4chvD3UskUFu1vij/5atay5EsZxqQ6WUswd+jeq+lz2sOEpWbMpfDofP94hiozQ9EwflFTdBxZjrN5b3msuY3S70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786151231; c=relaxed/simple;
	bh=hLY3y5m+xW/EOHr3olRy0N8NIN9E4C/A436qlb9hK+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/0coia1N0EzVyUJSgSsAwuID8VGMA3l4LaMSnLxywN0rt4c80guRr7oUlrRq/nZjrGOj27t4DJ9unWKIpMUjSwgva6DjOHFzm0MNuJ9+gealvuHW1p+gTj2ajqXnAAih35HI9tBcuTbdnL91ZJI7lsgIOvAQIKFQJo3uMZlCmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBbmZxtQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBbmZxtQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF73F1F000E9;
	Sat,  8 Aug 2026 01:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786151230;
	bh=z/2BGGjV0zJcUvZzXGXmS2anusXPas9uC4FDRLhddqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gBbmZxtQbR+4OLMlUQOJd0cR6xOh2hfPmr7InlIlFFeMIe/+oeKIsd2+9zA+6BX9O
	 d2AB7Vz8n5C0NoQMynnduoIONWzddAUuicvvZq9yMVT99PtVcTOEsd3z4LsjYrYlf8
	 l5uP7GXo84eHsvQn1AsIBL0N9QuO8QyZTxW4ihayXlDNWtp5CGw6a2YeWsQ/T8t7GE
	 67sw3x296Y/I1cDRkKtMeKRu2Df/GlVEvaWJlzETJxATYTGFKaS75/EYJQpMW4fTbl
	 /3ZfiPuxj25CdasV+L5Yhfho05KDkzC1HhZzWyeIXpZWdsW149JVkHmdua37fXOEIL
	 T1XTSPTB4SkpA==
Date: Fri, 7 Aug 2026 18:07:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net-next v4 1/1] af_unix: Do not wait for garbage
 collector in sendmsg()
Message-ID: <20260807180709.6fb7f2b2@kernel.org>
In-Reply-To: <bc759ceba26d6e20fab3bcf7333ee7e6246696b6.1785824313.git.namcao@linutronix.de>
References: <cover.1785824313.git.namcao@linutronix.de>
	<bc759ceba26d6e20fab3bcf7333ee7e6246696b6.1785824313.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Aug 2026 08:46:16 +0200 Nam Cao wrote:
> AF_UNIX sockets' sendmsg() schedules and blocks on the garbage collector if
> user has too many inflight unix sockets and there is cyclic reference in
> the system. This causes real-time issues, as cyclic reference can be
> created by any task in the system, and high priority tasks who do need to
> send lots of AF_UNIX sockets get blocked by the garbage collector which
> runs as workqueue, causing a priority inversion scenario.

Hi Kuniyuki! Any thoughts?
