Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E11D313267
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Oct 2025 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817553; cv=none; b=kdFX/3kNSZRufTMNebw1TMrx2MNdJc5dVeEK0pYoNim3yPmc5YoRvHTWP1AIDOJAAqjqSPmNdRZFsfQGrPOB5BACOnFzPgzS/qET/0hx+IV+dPoi/RyfDiD2xczz/5l5+/YK6iOFsikDjd8GpxXUQzKqrvJe+WyZBI/PnRhFExM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817553; c=relaxed/simple;
	bh=WlgBRANVN3+YbTo+yFypsvxtWyQmICDS3yPCmcNR/gI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwaqclnjkevxVbAQyBHYxZLQfP6VO3zy7pWORnmgR76RH0XE5lW/Q0wcKO4GgI3zObCQF/Hb78zvZ51p+BuAp6cpKh+xia3jG6ffQs9TyyIUNd7AWlZJrmsvpzWfK4KSbIjm7DFtxJ0q+TlplhEzKi98XKO2qBHJVeAvmjiMAC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 4DF4F140AA4;
	Thu, 30 Oct 2025 09:45:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 261E320011;
	Thu, 30 Oct 2025 09:45:44 +0000 (UTC)
Date: Thu, 30 Oct 2025 05:46:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Xie Yuanbin <xieyuanbin1@huawei.com>, arnd@arndb.de,
 linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev,
 linux@armlinux.org.uk, tglx@linutronix.de
Subject: Re: [PATCH 4/5] ARM: Disable jump-label on PREEMPT_RT.
Message-ID: <20251030054626.7a897b29@gandalf.local.home>
In-Reply-To: <20251030075558.sUBj8_6U@linutronix.de>
References: <20251030072339.63vdFNo3@linutronix.de>
	<20251030074507.33863-1-xieyuanbin1@huawei.com>
	<20251030075558.sUBj8_6U@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 261E320011
X-Stat-Signature: 5i5yd6u974bdqbc681j5faaz7soey96h
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19IpeKPkWpvJbWMuwiHyVexD2CuyYZN5D4=
X-HE-Tag: 1761817544-879611
X-HE-Meta: U2FsdGVkX19WE+mtTj5Z7AADdN/XCcXeOMC1S0doOEtQR7wUCgn4ESqevAO6ca/3neOKN5Amzh5LwJeu2ixyJkJOLAqm8+VmvLhFKM8fysbggbA6FqCujy5bOrh0dqh+6TBetfn39y1NXkkIIahwygxj2YdjbAd4IxUauPMy5zZ16m50/+NsjApYD2bDM4qm/MfRhMkIIZNniIKaqbFIc0gYCQrJJ8AllUZKzJQ6Z+JI6H3hsc4e/8EOoJEYylOBMuHhhjEn95q1Fz01x0Jw9TDNRF+X11AKJCa5vK0XNIRNPO94wmHMa2XYa+ESZxoVVz++Syx7mLB9+Uf/ks5nOy7ceAh/rQVb+vbg3ds9F/L5l4ZLu6l11g==

On Thu, 30 Oct 2025 08:55:58 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> You can't really control when jump labels are enabled/ disabled. For
> instance this happens if you enable/ disable trace points.
> Arm64 and X86 replaced the stop_machine() logic with something else that
> does not affect latency in that magnitude. If Arm could something
> similar then fine but until then I don't see a way around it.
> There are other things that are disabled on PREEMPT_RT due to latency
> reasons such as transparent huge pages or expedited RCU.

But transparent huge pages and expedited RCU are not user controlled events.

Enabling function tracing was known to cause huge latency for a very long
time and it came from the PREEMPT_RT patch set. Heck, printk use to as well ;-)

Instead, we could print a message to the console stating that a huge
latency has just occurred due to user activation. Similar to what we used
to post when RT Throttling happened (I don't see that message anymore since
dl_server was added :-/).

-- Steve
