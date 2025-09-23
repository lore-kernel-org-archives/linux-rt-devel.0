Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E614B2E972C;
	Tue, 23 Sep 2025 23:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758670013; cv=none; b=trfxFzLWSNPlFAut8MZt746W/qYh5gvhH6OpePBz/6NHrsTenauKmnXA/g1+Id81E2ISTfylw24kAliH2xd+CQ+33w6dKZZ6KCqabyhHTfTVucO3gcAuYw0iNsAkWP4dTlJniWG1Yj1hGObM3jVG68PJqkXpHHBZ5ugKbPFBpkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758670013; c=relaxed/simple;
	bh=lKlWiJd3M7QDuAOXQBGO4IRPr8x7/GMM9g9S7HUMktg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l6RJuUe+XdiXbsltxeRFxbJ4wL4ajcYLzydscFfYdcMpmHIxiuHyGZWMTg5S4ugx5qLSjvFxrtgAU1Ao2vjkESgTVQKRQIKkH4+u4vvK30/57C3CYNKaqQJtUTtgwhvqe7hy5yGX0XyqcXfKZKGQrzxQCRYdl3MvCPH6Xg2JVJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ft1eCxVU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ft1eCxVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B188AC4CEF5;
	Tue, 23 Sep 2025 23:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758670012;
	bh=lKlWiJd3M7QDuAOXQBGO4IRPr8x7/GMM9g9S7HUMktg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ft1eCxVUKQlIQBZe2ba5m2uTpzxNcXPCMaQXUD+I1Hmr2l6lGLnzAwStdL6HhqjGy
	 KCswBoNri8NK4J17QSL3p5Ps30rFwBiP1za2gbNOlS1y1WVE0HwwcPh+gQUFZr7bm+
	 msrtxp18FYK6LY3BhrexBKImIgHaLYfT90cIGHmitrds6m5WBeFKUN9Q9+RXnDhAi/
	 1VxWuWHthixphvhG9N6WGhNKIh4Or6AzdOELq2pRHxnDq+0/Mgi3yyqI/JufNKSZvG
	 lL4zGTDIhb4ynx4NKyWBuKuAgpSRXJe4IEAIpI1pZb/vAkDR/oQj6i7zve+8Y3rFnS
	 4luEf1q6U7M3A==
Date: Tue, 23 Sep 2025 16:26:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net-next] page_pool: add debug for release to cache from
 wrong CPU
Message-ID: <20250923162650.317f2527@kernel.org>
In-Reply-To: <ztotepnqvbyzwtmqox5433lp6wix6jzj6tf3zkagwvfzf33trz@khcwhwwg7gxx>
References: <20250918084823.372000-1-dtatulea@nvidia.com>
	<20250919165746.5004bb8c@kernel.org>
	<muuya2c2qrnmr3wzxslgkpeufet3rlnitw5dijcaq2gpy4tnwa@5p2xnefrp5rk>
	<20250922161827.4c4aebd1@kernel.org>
	<ncerbfkwxgdwvu57kmbdvtndc6ruxhwlbsugxzx7xnyjg5f6rv@x2rqjadywnuk>
	<20250923083439.60c64f5e@kernel.org>
	<ztotepnqvbyzwtmqox5433lp6wix6jzj6tf3zkagwvfzf33trz@khcwhwwg7gxx>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 16:00:27 +0000 Dragos Tatulea wrote:
> > But you get what I'm saying right? I'm questioning whether _rx_napi()
> > flavor of calls even make sense these days. If they don't I'd think
> > the drivers can't be wrong and the need for the debug check is
> > diminished?  
> I got the point for XDP. I am not sure if you are arguing the same thing
> for the other users though. For example. there are many drivers
> releasing netmems with direct=true.

Right, I was thinking that XDP is the only complex case.
The other direct=true cases generally happen on the Rx path
when we are processing the frame. So chances that we get the 
context wrong are much lower. XDP is using the recycling from
Tx completions paths IIUC. So we need far more care in checking
that the frame actually came from the local NAPI.
