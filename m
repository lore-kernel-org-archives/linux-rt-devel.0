Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFAB39E6E8
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Feb 2026 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771942819; cv=none; b=TJaI7D9Faq6vqepE6gR1pHwEd1qq2nkEfm+vaGHNdRF+5LrPuZ17RyW+7iTQckybS+Wg1VtrNm2HNfgLwTbmKChqkgjPvZ465CZQPdh0xNdom7MeDZrVv05LiOubKIok3S3/uUu6g49Owza128o7gNohnBcHda/uEYeKF1W5IgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771942819; c=relaxed/simple;
	bh=/fgIUtbn/ubpDgbXYLiD88WG23C8OSnlkojzMAds5t8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMrkeHPvvMV3wq+EJDYsEAxetwyG9vB8pP7S0H5Qo2QNc0ewdbngALIWVX9htMLtqWhQIptOoGpZayt+8lMmzg7+B06LXaLZClLiEcJphNWmTmLVfv85bpoq7RDljC9sTJHI5oYTdoh4zmEbhzHdCL43R7SaGNnerx9VvYjg0hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 3C11A1B55DF;
	Tue, 24 Feb 2026 14:20:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 9653D20025;
	Tue, 24 Feb 2026 14:20:08 +0000 (UTC)
Date: Tue, 24 Feb 2026 09:20:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Calvin Owens <calvin@wbinvd.org>, Tejun Heo <tj@kernel.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>, dschatzberg@meta.com, peterz@infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: ~90s shutdown delay with v6.19 and PREEMPT_RT
Message-ID: <20260224092005.01a0cd75@fedora>
In-Reply-To: <e76913d8778d3eb1d759cdd3239a2963216b9328.camel@web.de>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
	<20260219164648.3014-1-spasswolf@web.de>
	<aZd4YCNTAHZNpTfh@mozart.vkv.me>
	<594b9094ab76acf9e73cad8fca9c9efd6f75a980.camel@web.de>
	<20260219195851.7a7bd1b2@fedora>
	<1d56c93ee93334b9d320c93d255d7548f4497836.camel@web.de>
	<20260220104420.54610b04@gandalf.local.home>
	<ba582a2511d8cd4cda5a186ec48263076ac885cc.camel@web.de>
	<20260223032257.4e6db467@fedora>
	<80f657156fb2d32d8fe246e65e9ac8bf9d7cfbd5.camel@web.de>
	<e76913d8778d3eb1d759cdd3239a2963216b9328.camel@web.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: oc1i4raaqetnrtq4xfcpsk47cyeykfm7
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 9653D20025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+E+VCMAV6xz8vykyZOJrFGnN1jBCNmOWI=
X-HE-Tag: 1771942808-672914
X-HE-Meta: U2FsdGVkX19TtaZrl6TLZstQQSYazOqZAhXo+2i8NvfiUkMWoQlAZEpc8O8JBpBZfPVo6vpAnaLo5mL7VaPcVYMhD/pKC9P1eCwcDFgAz2koVIpN6oIJgY/m1LqE5o/uOQS58wN5Rtguj0j9/VI9629xnTv4zCNOZGuVJDk3SXIbwUKIK+kOAV890wuSh7dJcmzxukMISeOeDq22jGhyA1u/7KB85EPSkrqNTifStkcYRr1iEDCOP7rbidI8sLetVkoFcZbn+kODt7+nIFC7dTSWAuWrhdiOc2cJ5DqsjI8BSqJqpYVTpakj4stHBIz7pT/EFEnVN8WauyD0Qj2ri8m0F+nVDMdg23QLhQpar9rl8WMvraCH4A==

On Tue, 24 Feb 2026 00:36:27 +0100
Bert Karwatzki <spasswolf@web.de> wrote:

> As the bisection in suggested that commit9311e6c29b34 ("cgroup: Fix sleep=
ing from invalid context warning on PREEMPT_RT")
> is somehow causing the problem I put some printk()s in the code changed b=
y this
> commit and captured the output via netconsole (I tried using trace_printk=
() to
> use the persistent ringbuffer but got no output).

It's described in the document I posted:

   https://docs.kernel.org/trace/debugging.html

    Using trace_printk() in the boot instance

    By default, the content of trace_printk() goes into the top level
    tracing instance. But this instance is never preserved across
    boots. To have the trace_printk() content, and some other internal
    tracing go to the preserved buffer (like dump stacks), either set
    the instance to be the trace_printk() destination from the kernel
    command line, or set it after boot up via the trace_printk_dest
    option.

    After boot up:

    echo 1 > /sys/kernel/tracing/instances/boot_map/options/trace_printk_de=
st

    From the kernel command line:

    reserve_mem=3D12M:4096:trace trace_instance=3Dboot_map^traceprintk^trac=
eoff@trace

    If setting it from the kernel command line, it is recommended to
    also disable tracing with the =E2=80=9Ctraceoff=E2=80=9D flag, and enab=
le tracing
    after boot up. Otherwise the trace from the most recent boot will
    be mixed with the trace from the previous boot, and may make it
    confusing to read.

-- Steve
