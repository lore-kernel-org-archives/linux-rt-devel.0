Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFBA27E076
	for <linux-rt-devel@lists.linux.dev>; Tue, 23 Dec 2025 02:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766457499; cv=none; b=BApZ/GWd+4ZfeAu//4XmxVt6wUGL7PDbIrtO81VXmVDYA7R4TdU3PAcUE6H5WZJ5XhHSkf9Ju36CqGCG4/ekPn3N1IHbG9xIosSj1RrMJcwy8dQfdr1CO2vhgiEPIYAPWqMr5ZghYBMwqMONX9nxW3hcuyujEZ2Y02KDnCdbfFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766457499; c=relaxed/simple;
	bh=dIKWOo8YL9XeTr1lW67VL/yCD0Tufj7qehZgxf04a+Q=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=R845zkEJ6d/HOhpKjvjHwWuZqS+yj+JnK+1ML/Q6fILeKVwA+UBT+wvpzjqdiKCZtqH+gWue4bQP5kV+n/0GST3N1dPXdDHCLASDR2eCc2gZpZTnoQVoBqoI19bvOmJp2tWVrFzW5Qf+tdp7S0Bpm//1yVVuqWAMViufj3ilLkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ArCKmIYk; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ArCKmIYk"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766457494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/A7HbKpgTjJW7jQqPeYrZs5kL1SDV4eFk1EHi5q6zlY=;
	b=ArCKmIYkignxuHuuMHgL8eCn2R8rYz1fF9lucl0Nr5BB9hFnsO13kSlOqeqrNukY82ubNR
	dKo5g/dCV5bP/pWxwBa/djwNhB57jGcq3kJfZjD1S/FTM0xRIXXHPyRxhL+oYIGcA9Z9zt
	D+wDwU9NZl71qyt3Jsk95uZonT1ewcM=
Date: Tue, 23 Dec 2025 02:38:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <7f7c32e627e7d0fd1be12865f253a67cd3af29a8@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v2] ipv6: fix a BUG in rt6_get_pcpu_route() under
 PREEMPT_RT
To: "Steven Rostedt" <rostedt@goodmis.org>, "Eric Dumazet"
 <edumazet@google.com>
Cc: netdev@vger.kernel.org,
 syzbot+9b35e9bc0951140d13e6@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, "David Ahern" <dsahern@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20251222122628.38e9bc89@gandalf.local.home>
References: <20251219025140.77695-1-jiayuan.chen@linux.dev>
 <CANn89iLeASUZyonYSLX0AG5mbC=gxux0efehkBc_j1bbj6xrvA@mail.gmail.com>
 <20251222121639.3953ea08@gandalf.local.home>
 <20251222122628.38e9bc89@gandalf.local.home>
X-Migadu-Flow: FLOW_OUT

December 23, 2025 at 01:26, "Steven Rostedt" <rostedt@goodmis.org mailto:=
rostedt@goodmis.org?to=3D%22Steven%20Rostedt%22%20%3Crostedt%40goodmis.or=
g%3E > wrote:


>=20
>=20On Mon, 22 Dec 2025 12:16:39 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
>=20>=20
>=20> On Mon, 22 Dec 2025 09:50:58 +0100
> >  Eric Dumazet <edumazet@google.com> wrote:
> >=20=20
>=20>  > Link: https://syzkaller.appspot.com/bug?extid=3D9b35e9bc0951140d=
13e6
> >  > Fixes: 951f788a80ff ("ipv6: fix a BUG in rt6_get_pcpu_route()")=20
>=20>=20=20
>=20>  I would rather find when PREEMPT_RT was added/enabled, there is no
> >  point blaming such an old commit
> >  which was correct at the time, and forcing pointless backports to ol=
d
> >  linux kernels.=20
>=20>=20=20
>=20>  Ack!
> >=20
>=20Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
>=20
>=20That was the first commit to enable PREEMPT_RT on any architecture (j=
ust
> happened to be x86).
>=20
>=20-- Steve
>

Thanks Steve, it helped a lot=20!
