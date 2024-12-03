Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017E61EF0AE;
	Tue,  3 Dec 2024 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239249; cv=none; b=sz9linUGOGOzC/s7qS0uz5TJagjW2o+DpaifOFbozxO3oQjHeCvn+ykXeYB/FpalN+VvbnalFPwP08GIuKPIpXimvm3cp2x2FbnsENmlC1FC9QqQPzuyIApFPeC6AiWnqNAkdvQZPL22bqXXAxSVcZW3w2WoDk2MU33Ca55ybQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239249; c=relaxed/simple;
	bh=/ME4+gce8iu1KzBrtgcT3UdQE85kbfEIoKsxbQ1NQs4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhRC2J+Ha31CfDTjckjPTR/YyNgrGKK/5BYzKlwn30QVkqLyD42KKApKz2yePJB072hzVDP0xXRobXj0RlIh6aItIZHjfXOYXoUasYTxIBf/2QYzy9ltChOexrA1V9WQhLTRRNxdbEV7uRUIv/GAsf/Hzdyef+oV9KzYX7mUHYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0E1C4CECF;
	Tue,  3 Dec 2024 15:20:47 +0000 (UTC)
Date: Tue, 3 Dec 2024 10:20:47 -0500
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
Message-ID: <20241203102047.5844de81@gandalf.local.home>
In-Reply-To: <GV1PR08MB105212FEF9251CA2B3AAF7FFFFB362@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20241125094816.365472-1-yeoreum.yun@arm.com>
	<20241125094816.365472-2-yeoreum.yun@arm.com>
	<20241127120954.0facd34f@gandalf.local.home>
	<GV1PR08MB10521520ABD7B72D92FD60DE9FB292@GV1PR08MB10521.eurprd08.prod.outlook.com>
	<20241202103853.26db0c13@gandalf.local.home>
	<GV1PR08MB105212FEF9251CA2B3AAF7FFFFB362@GV1PR08MB10521.eurprd08.prod.outlook.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 08:31:54 +0000
Yeo Reum Yun <YeoReum.Yun@arm.com> wrote:

> Hi Steve,
> 
> > Still should be documented somewhere. It should describe the maximum number
> > of feats that will ever be loaded. If there's a max, it makes it back to
> > O(1). With a 'k' of how long it takes to process the max number of feats.  
> 
> But with other patchset seems better
> since not only this function, but also for other functions too.

Which other patchset?

> 
> BTW, is there any example describing this I can refer? 

No, it's on our todo list for RT. To document the RT behavior of the
kernel. This is just one location.

-- Steve
