Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582782;
	b=U0kw6+DoeVs3mnGBa7/RCBYjZAuW7rWBzoV2iIFFzrIu4U/fV/99ZKvHfMzH8f7nDEdp
	 IhK2XoRLHjYj+FOIJ9M/z/er6uDebWBKUqTqQheDsIoP3J92BDFl5t23NvXAsBcmI7eZJ
	 euP3K/nCGKGLe8br9h5DFZyrOPxSVJwvLrvDvKYBR/Nle2T+xjGQR5CpHadVMhaXZEOkG
	 FzT39P1fvguYlQHUAMloUQWZaXaHJpMU2Eynuk3YV1xB8Jw+zb+ru+pHJmwEa4+nsMyxA
	 72XEXYVRb3BlVwO88V3kGvQPYABALMUjKU06Zk+m9hfU+u5cZvymiUAv4ptWMKH+CSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582782;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=WDUSqIzvagAi6A91Fak+66DHMKH7R3y/uiOt+fyuEM8=;
	b=0xtVWH+68Gv0/OKbb6elmGLjFd3yTfpxwKJ77KUsfIK/vH6eLkf2SYRC2sU1DPY6wCcg
	 c/kJsT/BMJpRPaMdIyFsNomGHt3+2usH70helwCkmewR6mY0lWd2AW7qhtZPt/gx5WlGa
	 n4HIlOlINnAI2u/Oud+KF/IJOF1aEPmRP5vIz/ZcHs9ylpduWJd3Ss4m0oGS+oMxEIryJ
	 Ek8qKLTkvziup26JEWIl+AgJ2KFV4C9bcDOjeMQVv7N4mmJNGOzu4nrzmXQ0OQSIxhvj8
	 BzzqBQZ+nOuELO987qnufyTcH9tRdIlAOBN9yJvaeiypat55N26oNGOJNkb56W+NE5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O9JLfnlN;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D14606A327
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 15:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21D14606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O9JLfnlN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794582781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDUSqIzvagAi6A91Fak+66DHMKH7R3y/uiOt+fyuEM8=;
	b=O9JLfnlNBmtN7bWMfZnRMMa6L2B6iiMU+3BrTjP9ZFF779eaLTtUioBrlgOlRbgKeo1H2N
	PNBRDL8ZWBtkR6nTaJBuD5TSRB2Zd83pR7Dapc7ISf0ncGlALZFpvViiYQBgQhMXlMk5LX
	REkkJnv6d4oblaSUKRItD4Tt0cZ+VJc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-ML80U-iGNRCSg4mDy7dQow-1; Fri, 13 Nov 2026 10:12:59 -0500
X-MC-Unique: ML80U-iGNRCSg4mDy7dQow-1
X-Mimecast-MFC-AGG-ID: ML80U-iGNRCSg4mDy7dQow_1794582777
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc73895c7d5so1171296a12.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 07:12:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794582777; x=1795187577;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WDUSqIzvagAi6A91Fak+66DHMKH7R3y/uiOt+fyuEM8=;
        b=2AXtPwfLCJmTr81IfJF1jQr55iP/FIzIh7weiyw1S5kMrSiMAQpWFtMkp8ey8TpST3
         HiXwian1w0yv3bHa1hDehyNBtr1WoTTxDE/86ZHI0gDUDpMgxdO7/xs+RUJ2LW/69PxT
         aYnQxk+8cPcrch5AmMlH0jyYYc/2XJGzQo6lqyGyg4hMUY3t0Z0qENXZYxFFKGXLeICi
         SkJV4JT5vWs4tcMYwZwroQjCZna4e+SZjziCUdUfNWuTNFsFNVrlB4U8DxE2yzatstan
         jpVgQJeDXNkkHodj0R1VTcxshbpc0QIXg75ZZmSgNQlA75P02M6DnDhaMcccPXJzRr0y
         Mt5Q==
X-Forwarded-Encrypted: i=1; AL+hErHRFsJwfO2XdjLgUGD77WTpuQYBZlQeiZ5bI7NP9MTDloJvnlVLxZSjvKGd+jf850cMB9x5+8q6xLclKaKeEw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+VbNWp7bZkChejVB3w8UgL2HWK6WdbEf02zpaZlhI1gCylWI90
	Q80eUvRRkW/tYHKrHW9GQXkPbxGo16YiaJTVdl3MHRFS5C62e4el659nk0GE9R3B2hlBtbcOxRx
	CW1ULgHYWfakaXum9c74Hii6duehg+ZBnFsaZPnRXPMKGMwUrgr6J7HrDIWX4qxlliUZ8tXuVZw
	yxz8MBx0HjZcCWmal7EXgDlKbD2N047lcycY1a3REe3pk=
X-Gm-Gg: AYBFou2G/Cqz9xXhuj+OKgdPn1s4pDa3cjCUBMZHowWyuSZPpBw/An6bD6v3xGsBheY
	WDz6IyJsQVDbWepGhGYz6i0GmoEDOhC/bUf/sx2CfXlYNffjfGn4PiDeT5iiSd4lZ3csqafwYQG
	UhkBrG/0m1cVY2Zc/amgfWagNDRlW074OZ5YAfqTvKNm6yqve07k/Cf+iOAO7e84ufnCZxkWakh
	Mxy6RKPmVy8YDk=
X-Received: by 2002:a05:6a20:e68c:b0:3e2:a849:64c0 with SMTP id adf61e73a8af0-3f7a85d9479mr2660411637.51.1794582777334;
        Fri, 13 Nov 2026 07:12:57 -0800 (PST)
X-Received: by 2002:a05:6a20:e68c:b0:3e2:a849:64c0 with SMTP id
 adf61e73a8af0-3f7a85d9479mr2660388637.51.1794582776845; Fri, 13 Nov 2026
 07:12:56 -0800 (PST)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261113-rtla-mlock-v2-1-14382f140da0@monom.org> <87o6bswzj9.fsf@jogness.linutronix.de>
In-Reply-To: <87o6bswzj9.fsf@jogness.linutronix.de>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 13 Nov 2026 16:12:42 +0100
X-Gm-Features: AclHuK_feLH1S3_TxeYU0u90CBSg25p2KMxJp7qcgxlk7RF6fKY5CRJ6z7vGJXQ
Message-ID: <CAP4=nvTswKUTSJiFRJK7KXAvc3JMLDCgXW=mSV6BO3mMucyWnA@mail.gmail.com>
Subject: Re: [PATCH v2] rtla/timerlat: Lock the memory of the user-space threads
To: John Ogness <john.ogness@linutronix.de>
Cc: Daniel Wagner <wagi@monom.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gR7mGDeYr8qageVHO-3efMHAzLLBzI117JfKyQnb-Mo_1794582777
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 3:56=E2=80=AFPM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> It isn't because the page faults show up as latencies. It is because
> doing non-real-time work with a real-time priority is stealing the CPU
> away from other real-time tasks that presumably have actual real-time
> work to do.
>
> This program peforms severeal non-real-time activities with the
> real-time priority, which is not setting a good example. But I am only
> reviewing your patch, not the full source.
>
> John
>

The only other activities the user thread performs with RT priority on
before entering the timerlat interface read loop are setting the
cgroup and opening the timerlat interface file descriptor. I agree
that ideally, setting the priority should be done just before the
loop.

However, I don't think either activity takes too long, so the
difference is probably negligible in practice. Unlike mlockall, which
(if I understand your point correctly) might pre-fault from disk

Tomas

