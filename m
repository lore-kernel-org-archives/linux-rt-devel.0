Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0552B405F7
	for <linux-rt-devel@lists.linux.dev>; Tue,  6 Jan 2026 00:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660215; cv=none; b=Gq5ufmbg3ZK2+EVQlhfprE1KWFP98bWElDddkgjSBtgPqwUJDQjHN8i8ZW3q9nlXd3XkeyYVBe+Wf7UhFmE3qWbyGIO4yKR+OyOukcSjobPblmzs4VVwQEjJqSyCzV89gez6OGtbq9VJMJ5SwJ2w458lUFL/VAqVpCpR2P7bKx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660215; c=relaxed/simple;
	bh=UZ9x7Epwc5fmXhERofa0d8TWOao1W2/oNIhxQXIZOik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AgsHgAYGr8WcXq1lbzgjFC+5mnlgto8XS90neR1hVc2//hlFYbKj5o08dTumQCFZvGJIDyBPxVrrqXjvJDviN/tCZ0PZc1YhWPRpe1xyq6ozhONx4TcgWNVyBOoFzaj/reuJYibaIpMJ/wc3FuTy0bnjZSGufMc23chg+6WGlMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 61E8A1A02E3;
	Tue,  6 Jan 2026 00:43:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 2E24720010;
	Tue,  6 Jan 2026 00:43:27 +0000 (UTC)
Date: Mon, 5 Jan 2026 19:43:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Nicolas Dufresne <nicolas@ndufresne.ca>, Stefan Klug
 <stefan.klug@ideasonboard.com>, Xavier Roumegue
 <xavier.roumegue@oss.nxp.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 4/4] media: dw100: Split interrupt handler to fix
 timeout error
Message-ID: <20260105194350.5a4c9138@gandalf.local.home>
In-Reply-To: <20260105234452.GH10026@pendragon.ideasonboard.com>
References: <20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-0-65af34d04fd8@ideasonboard.com>
	<20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-4-65af34d04fd8@ideasonboard.com>
	<1c04d8cd1a6cf29f45d7ea9422dd3fe0a633a957.camel@ndufresne.ca>
	<20260105163748.2488d506@gandalf.local.home>
	<20260105234452.GH10026@pendragon.ideasonboard.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2E24720010
X-Stat-Signature: iy34cyhyg5wz1guqwxsuoa6k7tw1x6i1
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18YtiCB37S/idAdoYakdlnpVu0tUG+ohy4=
X-HE-Tag: 1767660207-46973
X-HE-Meta: U2FsdGVkX1/DJzlAzI6xk4tY2V4+Ob/CfNnpBHctQwVX/HfiKc9DozQzYwfJyWRDz7RL9HnOPgLvBzSDdSe1eJaCma57m8bTzVq/kWnCEwPNu4lvWtJwYV8BU1zILJs0p4L0N2z9Zk1WvHeZPmQncNWACfw4P2WeLSs0QEOeFjyO1+ztMOpm10Ea7LVwS7dZ87uYFOyb/REznF17+hVgnO5KWXagsASggx3rPMmuj/ZRrdBxmiEudg0foj7l65iNxUZG7aSJqjKvMb9MjmypY1L+McHA5CzT9/uAHIDganPZdACJp2ICoZXdC8UlDAVFUZih2RoiJdt54cRJ537PxepguzBQZ4d3PaKMfd4SwWG62TpmdatfUq+E8qnDlcYk

On Tue, 6 Jan 2026 01:44:52 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> > Agreed. Because it doesn't seem to make sense to have a oneshot threaded
> > irq handler that doesn't have the two parts (non-threaded to acknowledge the
> > irq, and the threaded to handle it and re-enable it).  
> 
> Why is so ? Isn't oneshot meant exactly for this purpose ? It's
> documented as not reenabling the interrupt after the hardirq handler
> (which is absent after 3/4) returns, why would a hardirq handler be
> mandatory then ?

Because it's timing out. The error in the change log states:

    In the previous commit, the interrupt handler was changed to threaded.
    This sometimes leads to DW100_INTERRUPT_STATUS_INT_ERR_TIME_OUT being
    set after changing the vertex map. This can be seen by repeated error
    outputs in dmesg:

    dw100 32e30000.dwe: Interrupt error: 0x1

It needs to be acknowledged in a timely manner. That is best done in the
hard irq context where no locks need to be taken. It looks like the handler
also disables the interrupt on the device and will be reenabled after the
handler has completed (in thread context).

-- Steve

