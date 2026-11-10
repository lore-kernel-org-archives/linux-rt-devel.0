Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341695;
	b=uOcFQp3pAV6vtihKNUGvYZwN5dwOmjAFc8ZEa7XM7scmJ3PMmJ/Hq8Wq6cnlg2Ibaul0
	 pIWRZZUlEhkw941ULTV0NZuR5ihBL2cJLryrTam4GCW9x9gL+YmFFVDTLySwqA8dVhvHA
	 jvpoBel8zu+3NwyG694ZnqhmCvGL4FltMgkDyrNjHJVfNnnLrxHKGt+l1/lh4Mv+LvbN6
	 vVAhNZpSKJdHbM0MyfclC54QxsDNflhWkXPzwY/RJLLxaGxYlwm7xrnvJOEtEgIZ7b78Q
	 AoGzSNWgTSSL0c8k9dWD7eBz7eOLke1FUsNYY4wOwbHBKMw6a9icXix9l6mrY51tMxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341695;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=14T1p32+VtvUlhSErH4xscJ3EXnpusJwKW/S5Km45yo=;
	b=a7OyVs+1nRA82MB+rYCG6VeWxUbU7dOi1ZCRLpRBd0U7EnA+DbfCDcnlYhRJHdMN/44c
	 wSkKzHrJgeRcV8bRUsJx16YOnUfPnfy/H9JFOi11QAak/F7ngKbUtjo7hdl/teRtAmKnt
	 00nid9FUdvZsdSyzPdmlIi8UyfculWBCAdNtpK+wJvSulBlfZKR3ndYWn7jH5hZcdlGIs
	 wx3yjzpZlKSX4slqChJTTW/OqTgYr6/nLQHBrG1hxOZIBq4SjG9DGpBPYWpx2+e/PGwTQ
	 KKGMiWDi5g3wKAboIh+1FRraywor+9Z0I1j6r+yivxjedPwFZsy/AfQRTc1kxcCJLEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I8VlnlWa;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE45606A327
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 20:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAE45606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I8VlnlWa
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdb869327e7so2078604a12.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 12:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794341694; x=1794946494; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=14T1p32+VtvUlhSErH4xscJ3EXnpusJwKW/S5Km45yo=;
        b=I8VlnlWa6hkYWZwnzjuXL08dXGxZPzPwCqiQs3TY1YT6QQFUEtMZgk//exqoEnjHh3
         R9zarfzt+X1BmIEKTE/CKLmyK7uPMA63nZ+w8nXbdZTnt3ue/Ns9sM9Yw1yZrmzbvH8e
         6bt1BYpSMfS/ocsAxIURc8kqeaQutl4OFJQ77Q5kHkNur5PhsEaGMWTNXKm6/C1BmViK
         Puw6uxjU+tH1+pknfp6CIbolxJKzDD47rK7UlDOxeSS0a+6hYc3TFio8aUXGFfydjSld
         r8j98rf7P46cp3/2+YRX8Oik0uHa8YjPR5tXtR5kx8rXTg5j6YVhTHE4DSA3jOOf2yrX
         cefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794341694; x=1794946494;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=14T1p32+VtvUlhSErH4xscJ3EXnpusJwKW/S5Km45yo=;
        b=JML62rsSqL0vcweVMqHKzdtl2gWMm7+cBeizWNuqPSuOo5AfIe6hJ+Xmvg3Nb6qVja
         TQfKQ3eC+5k/oo/TVtCZnw4sTE7TkRPzyWryedBJkktOyz2m2EjU3AF4x6M7PRmG75yn
         iB41jJWX3OEl4GVWgH0zIkbkJbMlbS1j9F8sDZlbjYkURO8eHMOB3517mTz6lqIP0t24
         Fkbe1mPCJv5DBeD1ku4PhdtooSDdNM+ttPRBFeZNscSgMkrqvU7l2LiCWaT8ElnbGMG9
         l32i7ADgW0koA/VReletRlw0n6aV05Gzv7FkPuDvytFJGr5DiIbDXRxAciFaYZ82+sQr
         uIaw==
X-Forwarded-Encrypted: i=1; AL+hErGhX+c4GxhEyfxoy8Abvhg1WMQG6L7+MtMOnUm3Ta99eV70BP6NBVVdRZbYhyjF89+UWcdwVzbddlxDVpen/Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z9KflouOebkP3Bc+EAVd0Vdbl39Aecd9LrFCQq6y9josBlfU2MB
	tkesY3cvP3NvmeOmkz9BzIlq8H0IOZzDhupSjiq59+K0TfGc48uKwpSgovLSp6uQZRBOzMcj4Ve
	FQ1q0Ww==
X-Received: from plim16.prod.google.com ([2002:a17:903:3b50:b0:2e3:bd2:38ec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:904:b0:2e9:4048:3031
 with SMTP id d9443c01a7336-2edd7a1102dmr2284595ad.39.1794341693808; Tue, 10
 Nov 2026 12:14:53 -0800 (PST)
Date: Tue, 10 Nov 2026 12:14:53 -0800
In-Reply-To: <cd458ee9a0c2405349cd2aaecb180f0b2e757aa3.camel@infradead.org>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261105020104.2507083-1-dwmw2@infradead.org> <cd458ee9a0c2405349cd2aaecb180f0b2e757aa3.camel@infradead.org>
Message-ID: <avN7PfMdfZcYl7Gt@seanjc-mac.roam.internal>
Subject: Re: [PATCH v2 00/20] KVM: Use atomic SRCU for gfn-to-pfn cache,
 reinstate guest mode for x86 nesting
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, rcu@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Durrant <paul@xen.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, Fred Griffoul <fgriffo@amazon.co.uk>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Kunwu Chan <kunwu.chan@linux.dev>, 
	Kunwu Chan <kunwu.chan@gmail.com>, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026, David Woodhouse wrote:
> On Thu, 2026-11-05 at 02:00 +0000, David Woodhouse wrote:
> > From: David Woodhouse <dwmw@amazon.co.uk>
> >=20
> > Based on v7.4-rc1 (kvm/next doesn't have the atomic SRCU flavour yet),
> > this series:
> >=20
> > =C2=A0=E2=80=A2 Converts the GPC to use atomic SRCU, ditching the rwloc=
k which was a
> > =C2=A0=C2=A0 scaling and latency problem, and which PREEMPT_RT hated be=
cause it
> > =C2=A0=C2=A0 turned the rwlock into a sleeping lock=C2=B9.
> >=20
> > =C2=A0=E2=80=A2 Fixes the pre-existing bugs which torture-testing that =
conversion
> > =C2=A0=C2=A0 shook out: a guest-reachable dirty ring overflow from the =
hypercall
> > =C2=A0=C2=A0 page write (128 pushes of the same gfn against 64 reserved=
 entries,
> > =C2=A0=C2=A0 without PML), and a lost TLB flush request in record_steal=
_time().
> >=20
> > =C2=A0=E2=80=A2 Adds KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE, for V=
MMs which
> > =C2=A0=C2=A0 intercept the guest's MSR write and need to replay it from=
 host
> > =C2=A0=C2=A0 context=C2=B2.
> >=20
> > =C2=A0=E2=80=A2 Cleans up the intentional lack of dirty-tracking of Xen=
 shinfo and
> > =C2=A0=C2=A0 vcpu_info pages (Sean).
> >=20
> > =C2=A0=E2=80=A2 Converts steal-time / preempted status to use gfn_to_pf=
n_cache.
> > =C2=A0=C2=A0 (Carsten)
> >=20
>=20
> I love it when sashiko-bot finds things which my own local runs don't.
> I'm still iterating on the latter part of the series; I think it
> probably makes sense to merge the first half (patches 1-9 above), and
> the nested parts (below) can come later.
>=20
> Sean, what do you think?

Ya, I'm definitely in favor of that.  Even if Sashiko didn't find anything,=
 I
think I'd want to grab the GUEST_USES_PFN stuff separately.
