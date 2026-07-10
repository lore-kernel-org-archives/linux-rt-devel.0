Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC4343900D;
	Fri, 10 Jul 2026 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783698711; cv=none; b=M3xXoAel666aYexnacjKMm7/O8q8r7GzXDxESEEaQh4kKasaC1QWLwdBKY9p0YNJ15Wp3POPqSLGrC2soo6ZeFIqWo+j4f9DADK9NzGH+yWLZDQrffqSFbxTua25P0LUJSG0Cxo3mDPVqokXlNtLqROFrN/tsoKT5A360cgZOaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783698711; c=relaxed/simple;
	bh=dKPL7G6MWN2WeoDDdNLfaTNB5Dnm7/xQyq06wuppNnw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYkIZWumvAqB6g1sen9XQA6p7unormtu8hruWbfvPoOTw/5UQmuMdiipVYAtfkTr9H30praPpZJqzM0t6ioFS0hUsqyWYLjwgA7jh29nFaGnue43Sqh7CnBCX2AozYFcLEeK2RMDZC1UX6Xr7N+XOxIGF4lmE9AzI5nMYaaQh+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id D16D4C3419;
	Fri, 10 Jul 2026 15:51:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 5684F35;
	Fri, 10 Jul 2026 15:51:36 +0000 (UTC)
Date: Fri, 10 Jul 2026 11:51:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Greg Kroah-Hartman 
 <gregkh@linuxfoundation.org>, driver-core@lists.linux.dev,
 linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org, "Rafael J.
 Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Clark Williams
 <williams@redhat.com>, Danilo Krummrich <dakr@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Jan Kiszka
 <jan.kiszka@siemens.com>
Subject: Re: [RFC PATCH] sysfs: Add /sys/kernel/realtime entry
Message-ID: <20260710115145.32729a7c@gandalf.local.home>
In-Reply-To: <748a489687000b21d0e8f961fc2f9f963b0bc1d1.camel@siemens.com>
References: <20260709143108.UYeCUUcd@linutronix.de>
	<2026070922-kilowatt-matador-5e1c@gregkh>
	<20260709152214.rH1O_8SM@linutronix.de>
	<748a489687000b21d0e8f961fc2f9f963b0bc1d1.camel@siemens.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: pczfkw4pic8zowixuxnu8ijo337i3imb
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 5684F35
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+gSoD9vjOtYatAKBFZVrsjn1q6FQo9FQg=
X-HE-Tag: 1783698696-349742
X-HE-Meta: U2FsdGVkX1+qAMt7+pRTn1bdChLWqGJof49B1oQw7tr40jJxhX4ydfOn4nAvdQwkizNXQFaT2rKZAA+2wPggP3FkZddx7LGCit8wIzwdwPToTX6hCg5Q4ZpSY4WaTcXFLwU8C+I2wa3yMKz0g2SHI4pje4CzDeheiObtVW3bNdFSJs3co5DlptuLHFW8BzBx6d1/I3Nk55H0FRD1BP6dJTysRa1VAM/ywD9AwDh6sehXbfC/67FVaMp9h0H20+irlZgwBmKRck+MYgt31O4dfbH9GQPAux8S4Ixw2suNM7CJY7SfhwWc58bzMh+P46st7leavk7HmsAybnrDrDzEfsceRZxzyQjO

On Fri, 10 Jul 2026 09:23:16 +0200
Florian Bezdeka <florian.bezdeka@siemens.com> wrote:

> uname might qualify, yes, but keep in mind that this sysfs based API is
> already used, so a removal might break applications. Yes, userspace can
> be fixed / adjusted, but it remains bad style, no?

Then at most it will likely just stay in the -rt patch set. As it was never
mainlined, it's not breaking any user space that uses only the mainline
kernel.

-- Steve
