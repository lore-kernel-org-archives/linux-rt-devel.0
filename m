Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF547209691;
	Mon,  2 Dec 2024 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153872; cv=none; b=N+YqZDOAf6XxmHepd70T0xkUSqPo85LpqOUkTlbd8dn2BGBcrpAk0v+ba4wB0dgLILTUmYgYPn0Cua5dV8KAoTkvmzjzX44aqbeQ3r4SDhEK9GB0MT4VQ6W6V9pR8Z4/xvPltrbxlz4eWMBCc91wzlNesrXOkS6N/ZGW1VAIkbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153872; c=relaxed/simple;
	bh=mfe+rsjuny1ySz7+fcztmelHL8cytJSxWp5Fk6cu5AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=suSE8+CEeBuhYLjqiLsvd/2uHDC2TZafbxyNZ+8mJoU1qeY4qJzGrKhH6JKSLzOhL9sGGE+hBGw63UzPekfNlR074GSwSMdATFf7GLTObjhRTkPVd4FKCmdnzczvOuno/xiwJcFrtyxgKQ6y13efyFJqMVeqj0VvwDc77h6T54M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5688AC4CED9;
	Mon,  2 Dec 2024 15:37:50 +0000 (UTC)
Date: Mon, 2 Dec 2024 10:38:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yeo Reum Yun <YeoReum.Yun@arm.com>
Cc: Suzuki Poulose <Suzuki.Poulose@arm.com>, "mike.leach@linaro.org"
 <mike.leach@linaro.org>, "james.clark@linaro.org" <james.clark@linaro.org>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "bigeasy@linutronix.de" <bigeasy@linutronix.de>, "clrkwllms@kernel.org"
 <clrkwllms@kernel.org>, "coresight@lists.linaro.org"
 <coresight@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
 <linux-rt-devel@lists.linux.dev>, nd <nd@arm.com>
Subject: Re: [PATCH 1/9] coresight: change coresight_device lock type to
 raw_spinlock_t
Message-ID: <20241202103853.26db0c13@gandalf.local.home>
In-Reply-To: <GV1PR08MB10521520ABD7B72D92FD60DE9FB292@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20241125094816.365472-1-yeoreum.yun@arm.com>
	<20241125094816.365472-2-yeoreum.yun@arm.com>
	<20241127120954.0facd34f@gandalf.local.home>
	<GV1PR08MB10521520ABD7B72D92FD60DE9FB292@GV1PR08MB10521.eurprd08.prod.outlook.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Nov 2024 07:39:22 +0000
Yeo Reum Yun <YeoReum.Yun@arm.com> wrote:

> Hi Steven,
> 
> > We should start documenting what is not real-time "safe". That is, if this
> > code is executed, we have a loop here that holds a raw spin lock. This
> > appears to make the time the raw spin lock held to be non deterministic.
> > 
> > If someone is running PREEMPT_RT and expects deterministic behavior, they
> > cannot be using this code. That is fine, but we should probably create a
> > document somewhere that notes this.
> >
> > -- Steve  
> 
> I think it's quite deterministic becase the number of loop currently
> determined by the number of preload_feats.
> 
> Also, I don't think the number of  feats will be loaded as much as
> it can do undeterministic behavior since 
> the number is not many and it is quite predictable.

Still should be documented somewhere. It should describe the maximum number
of feats that will ever be loaded. If there's a max, it makes it back to
O(1). With a 'k' of how long it takes to process the max number of feats.

-- Steve

