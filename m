Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792852814;
	b=WNQ4fxtqLIFmtnw39Zzs4U1sgx8808s5NJFcrLgRM13rJdirphk0FFwXey2bB41x8lfi
	 YgCLDUz5+BhAGF//turi/Ll/dp8fcNjN6wS7R5sKnpGcpBglG0hwiRS06z1eFv1U6x/eC
	 0dvQMKrvjB+yPyorh/pAPprFLOErG4dSuMVuLM3WhF3ypBiFedHBaiAGltN6xA1/ydAau
	 kvqKudIQK20drAg/XfhRi6jGBF0PJIKKHkD4eDzRZW21BYuTC2NrLeGcBgeCg1WuHjNXM
	 pyLJrZBgkrJaLuW4DpmpZmd+85ihZGRds4BYheX9kNSPLME49PpnosRK+kxtfoamjLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=521MBfk16OaOkHeWnu+57WsvL6IjDdbIpPxbjAQEqUA=;
	b=XRSV3c08MLyKYI8v/fLxDlwTTDkHVRsC82iJsTH6lnZOhrDDR/S05zVobYThYOzbY58F
	 P6kERXtQNNQxh1ji77ReTTipAC3xPV153pIOmZrRay8y0kiRXIOqfE2hvT7L6500S+vK/
	 Av5SrtnrGueYRbKkkwcy5X196L6OVKCY5ZWeCfZD0Z/fGsmDjMxlVkUCqU5Aq3NA9gcQZ
	 sShxKBUY+0zxop5Jd/SDq/WasGWK5m9tb6nWDaIA7go1MYTRt+vZp5+FhmnmkK0oBx1R8
	 rpyW9IBKPZguMRIO7rnvgTZF0C79qpzfnXma9bXDoo4iuTw09YHwV1S5jZVUIjF2lbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Svv51vjc;
	arc=fail smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AC3606A31A
	for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 14:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8AC3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Svv51vjc
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a06c60065fso1384933b3a.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 07:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792852813; cv=none;
        d=google.com; s=arc-20260327;
        b=VP4jQHqr1H0KzzjHubJPA9qv6ql92ErvjRq62dAaHcGO7yxLeyjf3HrSUMsbPHyWJT
         78xPZFomc1G2fUs+iOJcRsDGbzN+yuxuuT6Kxa0Bq6vsiJOYqmqGmfcDqAvVEJCeyWFj
         TsEnodhwhCp0qqCWjDkwFCYCTuTblJs7KzptGpgpHVTnjIpwC+oeVlnGITAUjb2GV++s
         SKl43cNZBADU9B1HGNvugMoTH4rBHf1SBTMfUxVKyzQQbdKI01z0imEstnlMc2GX2yP/
         wkFGwGibbgvssgGLcRKbEPUBFBDLgLU1jMY0oDXDE8KKD4aAam7Q4R3SJaONSz+Pxe8l
         U2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=521MBfk16OaOkHeWnu+57WsvL6IjDdbIpPxbjAQEqUA=;
        fh=jgeUYLt48gKPlkV//5U7Nrz1n141pvRLkn8PnILPjAU=;
        b=aBmq0F3SrFQIvhrTA/1V2jUhCvcJsRJCJXEjFTCVcnf7ihAlQFoB7kFQ8Ar4vFiqAH
         F58RhZflieE4/l45azwB10pRzdxX21yS2sLAoadxGMAa6/BU/sco5stagYUbU1VdSZCc
         pcAwYIq/YZnEw7HOxArFA50uYEAy1aGE8Ne1ouKj0FaNHKDbvgyBgKsU4tTzWjLSV8m1
         M8Rq2K5ZxLHeWB2prEnThHpId1MxwnKAmNXqWNWpOpOLuGlfbURdFuIx+S2g281nQAH+
         DVaUDjbq2rX47CADsInT0Gv7ETB+vMnGEaVHCo+opgIWo7X5wxoGUaxZKCat2SDvmfER
         VnsQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852813; x=1793457613; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=521MBfk16OaOkHeWnu+57WsvL6IjDdbIpPxbjAQEqUA=;
        b=Svv51vjc55qWhbTBhcoOLm+ttICe5Eq9l0Yb4kIOUWq6IASZNynr7873QhS31vuVNa
         MGPg8mqSAAk8r7bSX4zA6In2KI2SKBwwg8PnhFJNWUqK4+GxZYXUFkV4eUfWo+N06Rq2
         lLdjj6RwLY4E8rW2LkmLuabtBG2hC4fiPhick=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852813; x=1793457613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=521MBfk16OaOkHeWnu+57WsvL6IjDdbIpPxbjAQEqUA=;
        b=mPGX24xlDBNPmsipeehcwtv52FpJ5zVPVvoRymvF2pi/O00PDKUpu3G8pQj0B+zrZi
         pVybNGKCGM4u5fFh2hpO6I5G1MERXtskqq6w2kk09NyQiNgT3DsFNt6KUZV2E/tkH6uc
         F+MhgUnkAT4xT7S5NEy15vFy2r5jYo5Cy2SBA5Akl1PyYRiyzf/wb/2UxJp33Gh9sr+t
         q6nYW11qOR30BwgFLrwZVHWqwrd9a1qDYmkOlUIYT5lXsY7GrO5BxcjKJzzsphyDmvEd
         JLiOFmZVbybeWfnNEgEVFvvnLY8WIoqEe4DzD2eplc0xl1xOwyrCsf3EfR/BGvub+j1e
         CQHw==
X-Forwarded-Encrypted: i=1; AKwUvBzb8qW9JMqWnrhTlTcTajCQda0lABGp1GOJYHbZGHmykuOMdZOT61F3X6q9O+yV1EHhY/+XTpu09hPC3oRsSQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJKgLUH6QjhZksoBVWYHOpjfzCIbpPHTlDrw8OSaZIXsYnXIqWK
	hDokh6JfjuVVF7gCFyetxNMlAGUPCqmorHBWq09U47MdO9+PdpYaiwpwwAcQ+kxrE7M1xhEre7H
	58bWRGq9w2RV959QAxoHtawKqStGMEw0wXonJwFQg
X-Gm-Gg: AYBFou0aU1PEleYXcDIBuf5m1asmyo4gASRWGpl5ecr3JAYFmWGg/EITpsYfHrgp46a
	C1FetO2MsTqjQwC4bek7IMTuMF5eF34hcv0s0uklPCL5GgO4lCcp3K2c2MW+TqYAOCHO1PABHf8
	hZFblCkm/TOr0W58tVmtWz4KWI3X2H729hF9MxWpuDhtHGhremRDj5r9+FH+lhQjD2V8ePI7iGt
	PCf2QmCMD1CSF6+/eWsEGoOuqwlrQaz9G3gKb4myCxCBOiAh73nxEvbLSb+Qw5BoVAub+W57y5b
	RTQpy4VbQ9noSebEhMfq58p5IieHOTilns59elhrE71Fg8ZFpABQ04KUfTvlsftvZH43mAKc/Ui
	13aFW/q7b/hhaVTYOba0iccgMH9LNZR0zfkt/vK95dOi7oPJ2q/3RnI+WWifo1YGxbxDt2AyGLj
	ULWcRemiuvYnE3CSY=
X-Received: by 2002:a05:6a00:3d0c:b0:89e:5133:d98b with SMTP id
 d2e1a72fcca58-8a36689cbb8mr1693557b3a.24.1792852813080; Sat, 24 Oct 2026
 07:40:13 -0700 (PDT)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <QDISC-Y0BY.v2.r0.20261024060625@mojatatu.com> <179285257342.3327.7748817772985184863@kernel.org>
In-Reply-To: <179285257342.3327.7748817772985184863@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 24 Oct 2026 10:40:02 -0400
X-Gm-Features: AclHuK_IPQcN5_Ds5eUFIjDiEWNIuOK2ju1JXDTN4ajqveh7Xxel1G0VGM3dksM
Message-ID: <CAM0EoM=yCSeB9+Q8gFsB8sjQhddM9qWh8DOfSqqNtp6byubv2w@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] net/sched: sch_teql: fix transmit-path regressions
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	owen kwan <owen@verialabs.com>, linux-rt-devel@lists.linux.dev, stable@vger.kernel.org, 
	sashiko-bot@kernel.org, zdi-disclosures@trendmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patch 1 is a followup of a report by sashiko and  two was an
independent bug reported by Owen that our reproduction system verified
- i believe they found it by using an LLM to look for similar patterns
of some previously fixed bug.

cheers,
jamal

On Sat, Oct 24, 2026 at 10:36=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrot=
e:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
