Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE53C5DAE
	for <linux-rt-devel@lists.linux.dev>; Mon, 30 Mar 2026 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869891; cv=none; b=p83OHoaGAW+386vDRoH0UytRLff+w3XwLyq+whMcw2NcttbJbCAkiFMpCXIHAs9HWLTTcOjjVcMfL7oq7kgy9qYcxO62q2i/SU0lR0YtOXDp3QGKZ8a9A/P3CeNPEJQnKPXtKD7dePEk+pFXiMzMI+svu0fVLCIjiMbtXCVJ9bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869891; c=relaxed/simple;
	bh=VLu2p216AtxEFUOd8o2Lcblw9d9dmfFqB+45rdl3ON4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aB8Xok6iIhqHxEdnmIRDu2eq68hh9PwLwqKDAjnXVz+YLRhNnvN/OoHMLAWzQRiqvrlycs/1KdEzSmiJT32jeyejQEMz62BFNqmS+D970pI18G7zM9SItm52d48Y6hBxtQNB4400NHkGU6RhmxatA7KAQMzxKGZgod7SjRDk0rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3M097AP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3M097AP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774869888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wva+hCkG0r8QYM/lNZHYEzgn+YSloTd3OjPA+1CBsBo=;
	b=D3M097APtPJANoOu7p7hHIYxhv8HhbUyWKAfJdBsh8lHIA50D+YJMiOCCazYmp5qVl0KFG
	rPACLOyIynPmc6V6fM67gJz1OfHYj6hayFOGpz78jPtH4KM4KZel/YeyzHTuLdQsISP16b
	y612kBpfdG5IO78NmKo2CYAAFUZ41VU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-_N1f6NhLPHS_UQWV6Qs_GA-1; Mon, 30 Mar 2026 07:24:47 -0400
X-MC-Unique: _N1f6NhLPHS_UQWV6Qs_GA-1
X-Mimecast-MFC-AGG-ID: _N1f6NhLPHS_UQWV6Qs_GA_1774869886
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4362197d1easo3228177f8f.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 30 Mar 2026 04:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774869886; x=1775474686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wva+hCkG0r8QYM/lNZHYEzgn+YSloTd3OjPA+1CBsBo=;
        b=V9mmEgsZIuVpxZCYrDUEUfQYKmUh+R0B9P16tAejOVC7EDplJwUcSWb/rXh00hZG8o
         2EdQ8nPPaTkSKaLdnwZNPn1FhCPT4z82KWFaUthU9aUV1kmegXrs40E1XAC8kEt0yF7t
         GvNSJ4EjI1kmgICM/UoFZLyPo7DtXhBhz2CKGOg2IiCwpxQGYvwOGO9QOAQGlIV6ZQ3A
         iKcrYhTrRbqJ6dASEGY5P86oivC+utXygcutM43tJAgCR1CzQD3sw5H/T9kZG1fsGW2p
         SXAknOpzpNHUeCsRFBs6bYqbPhDZpdwEA/MK/A4mL+3ph/UXkQdw/y8UJJGJ7kEyGTj8
         x+3g==
X-Forwarded-Encrypted: i=1; AJvYcCU+xahAOwrlqnbOHAv2jHS2LXLBdFkS01oXrXSYWjsfVQVuHHE6nrRSK6mf/HdJnk31//87jbU8xnEIzF7u9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2ayGg/8WQcUHTsargbukh65ZKTFkc31mwcV4QxtrsdI0wYqu2
	+YT10t/RDApxYNvn38JT+xGsF+DxI/eICjkMEjNY8cYOT+yFTNzcZX5CtA4Bz3L3pwLCLDzzL/v
	+Hz4b95ns812khymaDC7i9OWHNHiksGHTAhXspCpqjOQsDYZvl7YO30cWfO2T38b1/FxvA8YbAM
	KZBEGrWeIPtovb5cwtwceqgzhSmKHLprnJUj6k5xO9Ae4=
X-Gm-Gg: ATEYQzyWDSvfagK0parjYYElqwcqopKKD3K69okDFR5qHAy0NY9/zvqaY93thiyIYye
	BBVP9AmrZ37Ffv4308ZjDqA2K72y0mV064o2Ak30U10n3p8TPezle0ze+ULBIVm9y0sFOFvO5sS
	mzpEo0UOUdufAyh4dQyWn9yXfIisvVRboDmGIru+AS79MrY9YFWBw8pLWPgsrftQNYu8YqO5QDX
	UqtWT8/nLdVZz+DCiH2McukjEVGdl5sUI+yhlo99LHVaRlNG0M4YIrbN3+zbrNatydk6QmURssM
	acsm
X-Received: by 2002:a05:6000:25c7:b0:43c:f95c:3e66 with SMTP id ffacd0b85a97d-43cf95c3ecemr9163039f8f.21.1774869885574;
        Mon, 30 Mar 2026 04:24:45 -0700 (PDT)
X-Received: by 2002:a05:6000:25c7:b0:43c:f95c:3e66 with SMTP id
 ffacd0b85a97d-43cf95c3ecemr9162967f8f.21.1774869884851; Mon, 30 Mar 2026
 04:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260209161527.31978-1-shaikhkamal2012@gmail.com>
 <20260211120944.-eZhmdo7@linutronix.de> <aYyhfvC_2s000P7H@google.com>
 <aactOOfirdVRYfNS@acer-nitro-anv15-41> <ae2143b3-ce28-4c87-afcf-1505694246d8@redhat.com>
 <abMS7MALNrmluvh5@acer-nitro-anv15-41> <b51de5cb-8198-4664-afcc-7386ecda81a8@redhat.com>
 <acNwYsm4GfViqiJS@acer-nitro-anv15-41> <CABgObfb8POHRUmhu2yoH7B=m5eg_VQpmDcPoj=PttaRkN=dQTg@mail.gmail.com>
 <acfqnRZ4A_aYnm09@acer-nitro-anv15-41>
In-Reply-To: <acfqnRZ4A_aYnm09@acer-nitro-anv15-41>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 30 Mar 2026 13:24:32 +0200
X-Gm-Features: AQROBzCZvYZ7bCMWssfj9tfG6zjco3KlWMZnPARkek7xW1MG79EQJ3sUO0VdEhQ
Message-ID: <CABgObfZQM0Eq1=vzm812D+CAcjOaE1f1QAUqGo5rTzXgLnR9cQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: mmu_notifier: make mn_invalidate_lock non-sleeping
 for non-blocking invalidations
To: shaikh kamaluddin <shaikhkamal2012@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kvm <kvm@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	Shuah Khan <skhan@linuxfoundation.org>, me@brighamcampbell.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ddP8Yq0K2-F21AA97LUwF4NGKFA-hqZcj6UJL250gmA_1774869886
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="000000000000029cc5064e3c19d9"

--000000000000029cc5064e3c19d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2026 at 3:50=E2=80=AFPM shaikh kamaluddin
<shaikhkamal2012@gmail.com> wrote:
> +void __mmu_notifier_oom_enter(struct mm_struct *mm)
> +{
> +       struct mmu_notifier *subscription;
> +       int id;
> +       pr_info("Entering :func:%s\n", __func__);
> +       if (!mm->notifier_subscriptions)
> +               return;
> +
> +       id =3D srcu_read_lock(&srcu);
> +       hlist_for_each_entry_rcu(subscription,
> +                                &mm->notifier_subscriptions->list, hlist=
,
> +                                rcu_read_lock_held(&srcu)) {
> +               if(subscription->ops->oom_enter)
> +                       subscription->ops->oom_enter(subscription, mm);
> +
> +       }
> +       srcu_read_unlock(&srcu, id);
> +       pr_info("Done:%s\n", __func__);

Yeah, calling mmu_notifier_unregister() won't work from within this functio=
n.

One possibility is for the new method to be something like this:

       void (*after_oom_unregister)(struct mmu_notifier *subscription);

So it only has to do

kvm->mn_registered =3D false; /* or xchg, it's the same */
WARN_ON(rcuwait_active(&kvm->mn_memslots_update_rcuwait));
if (kvm->mn_active_invalidate_count)
    kvm->mn_active_invalidate_count =3D 0;
else
    WARN_ON(kvm->mmu_invalidate_in_progress);

or something like that. See the attached sketch, feel free to reuse it
as you see fit.

Paolo

--000000000000029cc5064e3c19d9
Content-Type: text/x-patch; charset="US-ASCII"; name="mm.patch"
Content-Disposition: attachment; filename="mm.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mnd3mn5p0>
X-Attachment-Id: f_mnd3mn5p0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9zdm0vbmVzdGVkLmMgYi9hcmNoL3g4Ni9rdm0vc3Zt
L25lc3RlZC5jCmluZGV4IDNiNjcwZWU0ZWIyNi4uN2IxNGQ4MDk5Y2MxIDEwMDY0NAotLS0gYS9h
cmNoL3g4Ni9rdm0vc3ZtL25lc3RlZC5jCisrKyBiL2FyY2gveDg2L2t2bS9zdm0vbmVzdGVkLmMK
QEAgLTE5NzMsMTIgKzE5NzMsMTUgQEAgc3RhdGljIGdwYV90IHN2bV90cmFuc2xhdGVfbmVzdGVk
X2dwYShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGdwYV90IGdwYSwKIAkJCQkgICAgICBzdHJ1Y3Qg
eDg2X2V4Y2VwdGlvbiAqZXhjZXB0aW9uLAogCQkJCSAgICAgIHU2NCBwdGVfYWNjZXNzKQogewor
CXN0cnVjdCB2Y3B1X3N2bSAqc3ZtID0gdG9fc3ZtKHZjcHUpOwogCXN0cnVjdCBrdm1fbW11ICpt
bXUgPSB2Y3B1LT5hcmNoLm1tdTsKIAogCUJVR19PTighbW11X2lzX25lc3RlZCh2Y3B1KSk7CiAK
LQkvKiBOUFQgd2Fsa3MgYXJlIGFsd2F5cyB1c2VyLXdhbGtzICovCi0JYWNjZXNzIHw9IFBGRVJS
X1VTRVJfTUFTSzsKKwkvKiBOb24tR01FVCB3YWxrcyBhcmUgYWx3YXlzIHVzZXItd2Fsa3MgKi8K
KwlpZiAoIShzdm0tPm5lc3RlZC5jdGwubmVzdGVkX2N0bCAmIFNWTV9ORVNURURfQ1RMX0dNRVRf
RU5BQkxFKSkKKwkJYWNjZXNzIHw9IFBGRVJSX1VTRVJfTUFTSzsKKwogCXJldHVybiBtbXUtPmd2
YV90b19ncGEodmNwdSwgbW11LCBncGEsIGFjY2VzcywgZXhjZXB0aW9uKTsKIH0KIApkaWZmIC0t
Z2l0IGEvYXJjaC94ODYva3ZtL3ZteC9uZXN0ZWQuYyBiL2FyY2gveDg2L2t2bS92bXgvbmVzdGVk
LmMKaW5kZXggZTRjYjMxNzgwN2FiLi40YTFjMWY1Mjk3YzQgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2
L2t2bS92bXgvbmVzdGVkLmMKKysrIGIvYXJjaC94ODYva3ZtL3ZteC9uZXN0ZWQuYwpAQCAtNzQ0
NCw2ICs3NDQ0LDE1IEBAIHN0YXRpYyBncGFfdCB2bXhfdHJhbnNsYXRlX25lc3RlZF9ncGEoc3Ry
dWN0IGt2bV92Y3B1ICp2Y3B1LCBncGFfdCBncGEsCiAJc3RydWN0IGt2bV9tbXUgKm1tdSA9IHZj
cHUtPmFyY2gubW11OwogCiAJQlVHX09OKCFtbXVfaXNfbmVzdGVkKHZjcHUpKTsKKworCS8qCisJ
ICogTUJFQyBkaWZmZXJlbnRpYXRlcyBiYXNlZCBvbiB0aGUgZWZmZWN0aXZlIFUvUyBiaXQgb2YK
KwkgKiB0aGUgZ3Vlc3QgcGFnZSB0YWJsZXM7IG5vdCB0aGUgcHJvY2Vzc29yIENQTC4KKwkgKi8K
KwlhY2Nlc3MgJj0gflBGRVJSX1VTRVJfTUFTSzsKKwlpZiAoKHB0ZV9hY2Nlc3MgJiBBQ0NfVVNF
Ul9NQVNLKSAmJiAoYWNjZXNzICYgUEZFUlJfR1VFU1RfRklOQUxfTUFTSykpCisJCWFjY2VzcyB8
PSBQRkVSUl9VU0VSX01BU0s7CisKIAlyZXR1cm4gbW11LT5ndmFfdG9fZ3BhKHZjcHUsIG1tdSwg
Z3BhLCBhY2Nlc3MsIGV4Y2VwdGlvbik7CiB9CiAKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
bW11X25vdGlmaWVyLmggYi9pbmNsdWRlL2xpbnV4L21tdV9ub3RpZmllci5oCmluZGV4IDg0NTBl
MThhODdjMi4uM2M2N2VjMTVjMDljIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L21tdV9ub3Rp
Zmllci5oCisrKyBiL2luY2x1ZGUvbGludXgvbW11X25vdGlmaWVyLmgKQEAgLTIxMiw2ICsyMTIs
MTQgQEAgc3RydWN0IG1tdV9ub3RpZmllcl9vcHMgewogCSAqLwogCXN0cnVjdCBtbXVfbm90aWZp
ZXIgKigqYWxsb2Nfbm90aWZpZXIpKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKTsKIAl2b2lkICgqZnJl
ZV9ub3RpZmllcikoc3RydWN0IG1tdV9ub3RpZmllciAqc3Vic2NyaXB0aW9uKTsKKworCS8qCisJ
ICogQW55IG1tdSBub3RpZmllciB0aGF0IGRlZmluZXMgdGhpcyBpcyBhdXRvbWF0aWNhbGx5IHVu
cmVnaXN0ZXJlZAorCSAqIHdoZW4gaXRzIG1tIGlzIHRoZSBzdWJqZWN0IG9mIGFuIE9PTSBraWxs
LiAgYWZ0ZXJfb29tX3VucmVnaXN0ZXIoKQorCSAqIGlzIGludm9rZWQgYWZ0ZXIgYWxsIG90aGVy
IG91dHN0YW5kaW5nIGNhbGxiYWNrcyBoYXZlIHRlcm1pbmF0ZWQuCisJICovCisJdm9pZCAoKmFm
dGVyX29vbV91bnJlZ2lzdGVyKShzdHJ1Y3QgbW11X25vdGlmaWVyICpzdWJzY3JpcHRpb24sCisJ
CQkJICAgICBzdHJ1Y3QgbW1fc3RydWN0ICptbSk7CiB9OwogCiAvKgpAQCAtMjg3LDYgKzI5NSw3
IEBAIG1tdV9ub3RpZmllcl9nZXQoY29uc3Qgc3RydWN0IG1tdV9ub3RpZmllcl9vcHMgKm9wcywg
c3RydWN0IG1tX3N0cnVjdCAqbW0pCiB9CiB2b2lkIG1tdV9ub3RpZmllcl9wdXQoc3RydWN0IG1t
dV9ub3RpZmllciAqc3Vic2NyaXB0aW9uKTsKIHZvaWQgbW11X25vdGlmaWVyX3N5bmNocm9uaXpl
KHZvaWQpOwordm9pZCBtbXVfbm90aWZpZXJfb29tX2VudGVyKHN0cnVjdCBtbV9zdHJ1Y3QgKm1t
KTsKIAogZXh0ZXJuIGludCBtbXVfbm90aWZpZXJfcmVnaXN0ZXIoc3RydWN0IG1tdV9ub3RpZmll
ciAqc3Vic2NyaXB0aW9uLAogCQkJCSBzdHJ1Y3QgbW1fc3RydWN0ICptbSk7CkBAIC02NjEsNiAr
NjcwLDEwIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBtbXVfbm90aWZpZXJfc3luY2hyb25pemUodm9p
ZCkKIHsKIH0KIAorc3RhdGljIGlubGluZSB2b2lkIG1tdV9ub3RpZmllcl9vb21fZW50ZXIoc3Ry
dWN0IG1tX3N0cnVjdCAqbW0pCit7Cit9CisKICNlbmRpZiAvKiBDT05GSUdfTU1VX05PVElGSUVS
ICovCiAKICNlbmRpZiAvKiBfTElOVVhfTU1VX05PVElGSUVSX0ggKi8KZGlmZiAtLWdpdCBhL21t
L21tdV9ub3RpZmllci5jIGIvbW0vbW11X25vdGlmaWVyLmMKaW5kZXggYTZjZGYzNjc0YmRjLi5k
ZWJhMDU2NDY4YjEgMTAwNjQ0Ci0tLSBhL21tL21tdV9ub3RpZmllci5jCisrKyBiL21tL21tdV9u
b3RpZmllci5jCkBAIC04MzUsNiArODM1LDU2IEBAIHZvaWQgbW11X25vdGlmaWVyX3VucmVnaXN0
ZXIoc3RydWN0IG1tdV9ub3RpZmllciAqc3Vic2NyaXB0aW9uLAogfQogRVhQT1JUX1NZTUJPTF9H
UEwobW11X25vdGlmaWVyX3VucmVnaXN0ZXIpOwogCit2b2lkIG1tdV9ub3RpZmllcl9vb21fZW50
ZXIoc3RydWN0IG1tX3N0cnVjdCAqbW0pCit7CisJc3RydWN0IG1tdV9ub3RpZmllcl9zdWJzY3Jp
cHRpb25zICpzdWJzY3JpcHRpb25zID0gbW0tPm5vdGlmaWVyX3N1YnNjcmlwdGlvbnM7CisJc3Ry
dWN0IG1tdV9ub3RpZmllciAqc3Vic2NyaXB0aW9uOworCXN0cnVjdCBobGlzdF9ub2RlICp0bXA7
CisJSExJU1RfSEVBRChvb21fbGlzdCk7CisJaW50IGlkOworCisJaWQgPSBzcmN1X3JlYWRfbG9j
aygmc3JjdSk7CisKKwkvKgorCSAqIFByZXZlbnQgZnVydGhlciBjYWxscyB0byB0aGUgTU1VIG5v
dGlmaWVyLCBleGNlcHQgZm9yCisJICogcmVsZWFzZSBhbmQgYWZ0ZXJfb29tX3VucmVnaXN0ZXIu
CisJICovCisJc3Bpbl9sb2NrKCZzdWJzY3JpcHRpb25zLT5sb2NrKTsKKwlobGlzdF9mb3JfZWFj
aF9lbnRyeV9zYWZlKHN1YnNjcmlwdGlvbiwgdG1wLCAmc3Vic2NyaXB0aW9ucy0+bGlzdCwgaGxp
c3QpIHsKKwkJaWYgKCFzdWJzY3JpcHRpb24tPm9wcy0+YWZ0ZXJfb29tX3VucmVnaXN0ZXIpCisJ
CQljb250aW51ZTsKKworCQkvKgorCQkgKiBhZnRlcl9vb21fdW5yZWdpc3RlciBhbmQgYWxsb2Nf
bm90aWZpZXIgYXJlIGluY29tcGF0aWJsZSwKKwkJICogYmVjYXVzZSB0aGVyZSBjb3VsZCBiZSBv
dGhlciByZWZlcmVuY2VzIHRvIGFsbG9jYXRlZAorCQkgKiBub3RpZmllcnMuCisJCSAqLworCQlp
ZiAoV0FSTl9PTihzdWJzY3JpcHRpb24tPm9wcy0+YWxsb2Nfbm90aWZpZXIpKQorCQkJY29udGlu
dWU7CisKKwkJaGxpc3RfZGVsX2luaXRfcmN1KCZzdWJzY3JpcHRpb24tPmhsaXN0KTsKKwkJaGxp
c3RfYWRkX2hlYWQoJnN1YnNjcmlwdGlvbi0+aGxpc3QsICZvb21fbGlzdCk7CisJfQorCXNwaW5f
dW5sb2NrKCZzdWJzY3JpcHRpb25zLT5sb2NrKTsKKworCWhsaXN0X2Zvcl9lYWNoX2VudHJ5KHN1
YnNjcmlwdGlvbiwgJm9vbV9saXN0LCBobGlzdCkKKwkJaWYgKHN1YnNjcmlwdGlvbi0+b3BzLT5y
ZWxlYXNlKQorCQkJc3Vic2NyaXB0aW9uLT5vcHMtPnJlbGVhc2Uoc3Vic2NyaXB0aW9uLCBtbSk7
CisJc3JjdV9yZWFkX3VubG9jaygmc3JjdSwgaWQpOworCisJaWYgKGhsaXN0X2VtcHR5KCZvb21f
bGlzdCkpCisJCXJldHVybjsKKworCXN5bmNocm9uaXplX3NyY3UoJnNyY3UpOworCisJaGxpc3Rf
Zm9yX2VhY2hfZW50cnlfc2FmZShzdWJzY3JpcHRpb24sIHRtcCwgJm9vbV9saXN0LCBobGlzdCkg
eworCQlzdWJzY3JpcHRpb24tPm9wcy0+YWZ0ZXJfb29tX3VucmVnaXN0ZXIoc3Vic2NyaXB0aW9u
LCBtbSk7CisKKwkJQlVHX09OKGF0b21pY19yZWFkKCZtbS0+bW1fY291bnQpIDw9IDApOworCQlt
bWRyb3AobW0pOworCX0KK30KKwogc3RhdGljIHZvaWQgbW11X25vdGlmaWVyX2ZyZWVfcmN1KHN0
cnVjdCByY3VfaGVhZCAqcmN1KQogewogCXN0cnVjdCBtbXVfbm90aWZpZXIgKnN1YnNjcmlwdGlv
biA9Cg==
--000000000000029cc5064e3c19d9--

