Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1722836C5BB
	for <linux-rt-devel@lists.linux.dev>; Fri, 27 Feb 2026 22:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772233057; cv=none; b=cC832M5BqKj9/hGCfVUqwp8biDgzFxfoCAB7Z53gqBmawaPIt1kgmTWILweBzk6Kyf8ETb97RwkolIoFLwQ/F9OKjASkot4BXJOuaWRmojchpUs6kIfT487G8IWcRC97FwEyT0n2Zdm+iiO4vTDtSEXAwXCWouPhL7y5kPGCzHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772233057; c=relaxed/simple;
	bh=CVuAvcm/y2Ly/qv5+fT+EvZKUxGrt000NGAyODFeuDI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qa+sfrXTuZPc8/WVc7/ElB9aRa0dDtpmIdFKOEuZGFf+kshAYLATH6ndj3w9mJ2Vd6J/tVKTmgUpTAr5ZaOJDJcxZACTNSRK0IBWUeSvGIw51Mfp39sC4pIWKGJIb8IXViDf+OcsTj0F4P/nNt3fJXwjG57I8bcEGgUgvftCJyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=nlLjXQvV; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="nlLjXQvV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1772233036; x=1772837836; i=spasswolf@web.de;
	bh=88HwpSTiIpxqxPx3DdSOUPZnIU283C8JnT5SYJRx+i8=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nlLjXQvV/OuWV5eG1Uv5FLG2t8dAQnYaVJk+8KrzbtBfoiPnSgl3q/lgmQG8PnLO
	 1m67PZvZuTd66qUTtOrl4BtmaBA30xtNFN/TotAzE2xpHoMA19k0qQYJ/MDKJfmL2
	 5s7Gn1KcUIr4IzM/OuOEIUsth6eKg5jNx/BuvWGE/Ei0aUpwtOId4KXfz374q9/uk
	 E0jDlx8jBaj2G1ILgv6cD2KKfrtliZFI5h/7p4qeVuOeRjzlc3wdaz/ZKfQKOZ1We
	 oh3HdDeW4Bdl6O8jzRwLzu0UjIflBMpcumBdGNNKR+SjILII2GHk7yPOfd/XWFeay
	 qZImpWU+bUVbSa6qjQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mhnw2-1vRSv239AO-00ZUbc; Fri, 27
 Feb 2026 23:57:12 +0100
Message-ID: <5a10aefc709b723820a6508a29823e89de947495.camel@web.de>
Subject: Re: ~90s reboot delay with v6.19 and PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	calvin@wbinvd.org, dschatzberg@meta.com, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Steven
 Rostedt	 <rostedt@goodmis.org>, spasswolf@web.de
Date: Fri, 27 Feb 2026 23:57:09 +0100
In-Reply-To: <20260227141332.74RtR9HK@linutronix.de>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
	 <20260219164648.3014-1-spasswolf@web.de>
	 <20260225154341.32AjXoVi@linutronix.de>
	 <6abee0b4bca811680a7f7fb6ab70bf27c6805cf5.camel@web.de>
	 <20260225165954.180aRkaV@linutronix.de>
	 <20260225223135.vjfaFo0c@linutronix.de>
	 <20260227141332.74RtR9HK@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W2OQCDSfF7TDytYbKEXEdaGXtw7LtDLzYRXSit/0XFN1H8sH0TX
 UVW2yaJonWtxUFkKa6Tn3Fk6ZgUx0nWrzQ0mJxc8Q7R/cxT64NOb1cJBtBcy3pzBI0O0iiU
 NCPdZuHfOSTGyxvodDuU5yr1Z1/BraubMpzKr88ZQzaulYwceuDZek2DzoX/FUUpFFsUq1L
 tXZN9dlUELCYsMwlLdmOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qMaOb7jek2A=;aYmQipoQYBSp2OdkVdddrclGQjg
 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

Am Freitag, dem 27.02.2026 um 15:13 +0100 schrieb Sebastian Andrzej Siewio=
r:
> On 2026-02-25 23:31:36 [+0100], To Bert Karwatzki wrote:
> =E2=80=A6
> > Until the sched_switch, everything is the same. But then systemd-1828
> > (the one with the cgroup_notify_populated event) seems to get impatien=
t
> > and sends a SIGTERM+SIGCONT. It gets the exit code, the
> > cgroup_notify_populated event is there later and just once. The
> > app.slice notify is missing. And the rmdir gets in much later.
> =E2=80=A6
>=20
> I so proud of myself. Bert, can you confirm that this works?
>=20
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5283,6 +5283,11 @@ static void *cgroup_procs_start(struct seq_file *=
s, loff_t *pos)
> =20
>  static int cgroup_procs_show(struct seq_file *s, void *v)
>  {
> +	struct task_struct *tsk =3D v;
> +
> +	if (READ_ONCE(tsk->__state) & TASK_DEAD)
> +		return 0;
> +
>  	seq_printf(s, "%d\n", task_pid_vnr(v));
>  	return 0;
>  }

I tested this with 10 reboots, it worked 9 times, one reboot was delayed (=
perhaps
for a different reason, sometime these delays occur on no-RT or older kern=
els, too)

Bert Karwatzki
