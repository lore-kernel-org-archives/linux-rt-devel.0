Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C5B26C385
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134802; cv=none; b=pJ5sy4pIykgGBN0kLW4h+lAhVl/GN0m5RNMwn7PUK8153zI6e6l23dgwd/fFxe2S0c8WgF5MN8B/UlUcvnvVpsxzxEEbYytgs1X1nrdItLJzWk0x3q5WwgYMbW46cZKzDpC5iX7da3CRY3xEaIfcVlPHzNU2140bCXmJLbYOZhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134802; c=relaxed/simple;
	bh=jpgXRxu/jFtNUHj70J1Fhw+uH83ssEjCn9599WRLcBo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJEVS3dzRQoxpLFBeOa//O3YgCcMjH5UGgWEy/Is2itwFFOSjRtr4AN4LFcsJVxB226GdTwNqtZTb8PkGjUebiitS0JPddXbdRoFxafmH3TH1EX8TJR4BBRJIbz8iIsZ/ez4EP2oeaMORaqt8/vkwjcbz7Bvg8E6g5XPHw6xK1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R4zaFGQ9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4zaFGQ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792134799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WoDCUFwbVOJWwST8IKV1IcNPnzzjo2MUogeoiQKoN0=;
	b=R4zaFGQ9oB/mv7wMHEIhi8nlKRX81Ee02Y/vXpk+uw2x8oSRYXlyg/d41mjYpVwDntzlqA
	rn/OZUr3+KsLKL1OW4JD9bjyt6QFew2OxWP3t5NbAOryybUM1KGFd4gGgne152F9gmIedb
	14DRuGMsAgm6vBVttKBo4CNsXD2R3Dw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-tsKZ6BqkMnSiilKvnHbhdQ-1; Fri, 16 Oct 2026 07:13:18 +0000
X-MC-Unique: tsKZ6BqkMnSiilKvnHbhdQ-1
X-Mimecast-MFC-AGG-ID: tsKZ6BqkMnSiilKvnHbhdQ_1792134797
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93ca9b53afaso1690150085a.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 00:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792134797; x=1792739597;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RSsvqnOIdQoXm08QIQqUtjgHDWmTd00XcUjeSVT2xtY=;
        b=IGkoOI8yM7G5prFpGdyFDoluG+CK8EjmvnSGnGv953bC7gmJU3oAwaxKfXvHsltIyj
         gSRRIQJa1NTjpjIbgNYG7MUsUDCJfxNZCy9+C7fyLZaR8S4txPenrQURnHmwQYbboc5g
         +9CTckRKEe06mlYfO+VRWBkOEVYCZF44bvxDSgr83aJi+UAoH0yoX6xuX/XkLzGaeL1U
         IU4Qb2zCnaY4kWnF3pNVBN5H844+ZQnfp7VB+CTDV8fEa6LpSbnuiNaeAM8oOz5IETvE
         1tuwxtCrO9cAJci1kD7uxRoZjdsZeMh46rtqWcb6vX/1hHiWLUXp4STuw/5pZskgr7Iq
         6vKA==
X-Forwarded-Encrypted: i=1; AKwUvBxTJf32j2FZlu9WTkyDwfHatMth2rZPUTAq3+rlh/XoSks6Nl6mmuSZS+X5IX/APUikJfh27rLoWO3mmY+9/g==@lists.linux.dev
X-Gm-Message-State: AFq9FYIoGS/jQDPPIGXSpHk9pkvEMcHuhIBCBuMDT+swQNZMZ6TkdMRu
	WmTspu6atlcu04DquXsN+YEvgQJC4w9skg9sW+XhwG3+jug+gwbYOn95mNlcJa57rlmIdhGXflf
	E1CKmPwyImv9HLoDH5XkEPtcnyGN6ruLRIPWV0VJfecPI6CfHw6iuhe8VTFvNXJ7plend
X-Gm-Gg: AYBFou0LSGvRMslFWkMfYJ2Y80wmEQedGYrpHxCwgzBixxIt5kLVaK0lwytsQR2ZpLF
	6KkocywGC0JLjT5jfjcghGXHKKo1orZ2kqPjH4SDiHpBqdt44MUha+jaFlvYmbVtT96mWe4aygx
	1ocLYTYwGe/pgLDK2lu43fBh8lzHgaqxXRVsYDl3MTw9aryIMZkbn3297VzhBpv00CdN+azoIer
	DaYpR3kY+HSEtS0TCh4Rl0nbiYd8mnkaMaB5BJ58ewusiv6ozes9j+fyo3NyND6f07eCwYRxjpH
	3G37XPMvBEc6Z9q2rQW4uNScD3hrccEv2nNGhj+ovp5swj7i4DCykkUZ52pv8JGPWCtRb9QulGX
	QBTgOPTO/fgIW4YNXaO+a5/wCX7ZfIcgeTOA3BsKS+xhmqygNYy+uSR8=
X-Received: by 2002:a05:620a:4489:b0:93c:5c60:c3a6 with SMTP id af79cd13be357-93ebd2a6dbamr3494145885a.66.1792134797352;
        Fri, 16 Oct 2026 00:13:17 -0700 (PDT)
X-Received: by 2002:a05:620a:4489:b0:93c:5c60:c3a6 with SMTP id af79cd13be357-93ebd2a6dbamr3494142985a.66.1792134796760;
        Fri, 16 Oct 2026 00:13:16 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a185ea6sm140965685a.21.2026.10.16.00.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 00:13:16 -0700 (PDT)
Message-ID: <876c9f1a6165b3a865811e7a94522afa2d4844fb.camel@redhat.com>
Subject: Re: Possible enhancement to RCU CPU stall warning messages
From: Crystal Wood <crwood@redhat.com>
To: Clark Williams <clrkwllms@kernel.org>, "Paul E. McKenney"
	 <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Steven Rostedt
	 <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev
Date: Fri, 16 Oct 2026 02:13:15 -0500
In-Reply-To: <atDw3O5RILsTE1mn@demetrius>
References: <a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop>
	 <atDw3O5RILsTE1mn@demetrius>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uFrsZPHufP_hjJT_ejWC23VeT0tuu_CsmwTA6lbQTNk_1792134797
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-10-15 at 10:27 -0500, Clark Williams wrote:
> On Tue, Oct 13, 2026 at 05:41:41PM -0700, Paul E. McKenney wrote:
> > Hello!
> >=20
> > While chasing an "interesting" bug [1], I modified the RCU CPU
> > stall-warning code so that when a task (as opposed to a CPU) is
> > blocking the grace period due to being preempted, the stall-warning
> > message includes the task that is currently running on the CPU that the
> > preempted task wants to run on.  (In the case of the "interesting" bug,
> > I kid you not, that CPU was idle.)
> >=20
> > Would this stall-warning addition be useful for PREEMPT_RT users?
> >=20
> > If it is not useful, I am going to keep it out of tree.  Something abou=
t
> > it needing a way to dig into scheduler internals.  ;-)
> >=20
> > But if you want it, please let me know.
> >=20
> > =09=09=09=09=09=09=09Thanx, Paul
> >=20
> > [1] https://lore.kernel.org/all/8fa7f795-518c-4507-b684-60b0c1cac2c5@pa=
ulmck-laptop/
> >=20
>=20
> Paul,
>=20
> While RCU isn't one of the common reasons for a latency spike, if it
> *is*, then it's not one that's easily tracked down.  For that reason I'm
> in favor of using your patch.=20
>=20
> That said, if it's going to be a pain to maintain, I can live without it.=
=20

RCU isn't usually the reason, but it's often the thing that actually
speaks up and says "something's wrong here", and being able to print the
task that has a good chance of being the problem (in cases where the
stalling thread is runnable) sounds quite useful.


-Crystal

